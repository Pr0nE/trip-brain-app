package main

import (
	"errors"
	"fmt"
	"io"
	"strings"

	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

func (s *server) Suggest(req *TravelSuggestionRequest, stream TravelSuggestion_SuggestServer) error {

	accessToken := req.GetAccessToken()
	basePlace := req.GetBasePlace()
	language := req.GetLanguage()
	likes := strings.Join(req.GetLikes(), ",")
	dislikes := strings.Join(req.GetDislikes(), ",")

	var suggestionCreditPrice int32 = 1
	var userId string

	if accessToken == "guest" {
		err := s.limiter.LimitRequest(stream.Context())
		if err != nil {
			return err
		}

	} else {
		id, err := CheckAccessToken(accessToken)
		userId = id
		if err != nil {
			fmt.Print(err)
			return status.Error(codes.Unauthenticated, err.Error())
		}

		// Check user balance is more than 0
		user, err := GetUser(userId, s.db)
		if err != nil {
			fmt.Print(err)
			return status.Error(codes.Internal, "Failed to check user balance")
		}

		if user.Balance < suggestionCreditPrice {
			return status.Error(codes.ResourceExhausted, "Insufficient balance")
		}

	}

	suggestPrompt := fmt.Sprintf(`I want travel To %s places which includes %s and exclude %s,
	Suggest list of 10 places in bullet .md format in %s language, no extra info. example:
	- place: why it match likes and dislikes in 1 sentence`, basePlace, likes, dislikes, language)

	result, found := s.cacher.Get(suggestPrompt)

	if found {
		responseObj := &TravelSuggestionResponse{
			Places: parseMessage(result),
		}
		stream.Send(responseObj)
		ReduceBalance(userId, suggestionCreditPrice, s.db)
		return nil
	}

	aiStream, err := getStreamChat(suggestPrompt)
	if err != nil {
		return err
	}
	var message string

	for {
		response, err := aiStream.Recv()
		if errors.Is(err, io.EOF) {
			ReduceBalance(userId, suggestionCreditPrice, s.db)
			s.cacher.Save(suggestPrompt, message)
			return nil
		}
		if err != nil {
			fmt.Printf("\nStream error: %v\n", err)
			return err
		}

		if len(response.Choices) < 1 {
			return status.Error(codes.Internal, "There is an internal error")
		}

		content := response.Choices[0].Delta.Content
		fmt.Print(content)
		message = message + content

		responseObj := &TravelSuggestionResponse{
			Places: parseMessage(message),
		}
		if err := stream.Send(responseObj); err != nil {
			return err
		}
	}
}
