package main

import (
	"errors"
	"fmt"
	"io"

	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

func (s *server) GetDetail(req *GetDetailRequest, stream PlaceDetails_GetDetailServer) error {
	place := req.GetPlace()
	detail := req.GetDetail()
	language := req.GetLanguage()
	accessToken := req.GetToken()
	var detailCreditPrice int32 = 1

	var userId string
	var detailPrompt string

	switch detail {
	case "features":
		detailPrompt = fmt.Sprintf(`key features of %s, in .md format, in %s language, use mobile emoji`, place, language)
	case "history":
		detailPrompt = fmt.Sprintf(`history of %s, in .md format, in %s language, use mobile emoji`, place, language)
	case "travelNotes":
		detailPrompt = fmt.Sprintf(`things to know before visiting %s, in .md format, in %s language, use mobile emoji`, place, language)
	default:
		return status.Error(codes.Unimplemented, "Unsupported Detail")

	}

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

		user, err := GetUser(userId, s.db)
		if err != nil {
			fmt.Print(err)
			return status.Error(codes.Internal, "Failed to check user balance")
		}

		if user.Balance < detailCreditPrice {
			return status.Error(codes.ResourceExhausted, "Insufficient balance")
		}
	}

	result, found := s.cacher.Get(detailPrompt)

	if found {
		responseObj := &GetDetailResponse{
			Content: result,
		}
		stream.Send(responseObj)
		ReduceBalance(userId, detailCreditPrice, s.db)
		return nil
	}

	aiStream, err := getStreamChat(detailPrompt)
	if err != nil {
		return err
	}
	var message string

	for {
		response, err := aiStream.Recv()
		if errors.Is(err, io.EOF) {
			ReduceBalance(userId, detailCreditPrice, s.db)
			s.cacher.Save(detailPrompt, message)
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

		responseObj := &GetDetailResponse{
			Content: message,
		}
		if err := stream.Send(responseObj); err != nil {
			return err
		}
	}

}
