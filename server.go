package main

import (
	"context"
	"fmt"
	"net"
	"net/http"
	"os"
	"regexp"
	"strings"
	"time"

	"github.com/joho/godotenv"
	openai "github.com/sashabaranov/go-openai"
	"github.com/stripe/stripe-go/v72"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"gorm.io/gorm"
)

type server struct {
	limiter *RateLimiter
	db      *gorm.DB
	cacher  Cacher
}

func main() {

	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error loading .env file:", err)
		return
	}

	// uncomment if you want tls
	// creds, err := credentials.NewServerTLSFromFile(os.Getenv("CERT_PATH"), os.Getenv("CERT_KEY_PATH"))
	// if err != nil {
	// 	fmt.Println("Error loading certificates file:", err)
	// 	return
	// }

	// s := grpc.NewServer(grpc.Creds(creds))

	s := grpc.NewServer()
	serverImpl := NewServerImpl()

	go func(server *server) {
		http.HandleFunc("/webhook", func(w http.ResponseWriter, req *http.Request) {
			HandleStripeWebhook(w, req, func(intentId string, amount int) {
				CheckPayment(intentId, server.db)
			})
		})

		fmt.Printf("Listening on %s", ":443")
		http.ListenAndServeTLS(":443", os.Getenv("CERT_PATH"), os.Getenv("CERT_KEY_PATH"), nil)

	}(serverImpl)

	port := os.Getenv("GRPC_PORT")

	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", port))
	if err != nil {
		fmt.Printf("failed to listen: %v", err)
		return
	}

	RegisterTravelSuggestionServer(s, serverImpl)
	RegisterAuthServer(s, serverImpl)
	RegisterPlaceDetailsServer(s, serverImpl)
	RegisterPaymentServer(s, serverImpl)
	RegisterGeneralServer(s, serverImpl)

	fmt.Printf("Server is running on port %s", port)

	if err := s.Serve(lis); err != nil {
		fmt.Printf("failed to serve: %v", err)
		return
	}

}

func (s *server) GetPlaceImage(con context.Context, req *PlaceImageRequest) (*PlaceImageResponse, error) {
	place := req.GetPlace()

	imagePlaceCacheKey := place + "Image"
	cacheResult, found := s.cacher.GetArr(imagePlaceCacheKey)

	if found {
		return &PlaceImageResponse{ImageUrls: cacheResult}, nil
	}

	result, err := FetchResponse(place)

	// Uncomment to use DuckDuckGo for images instead of unsplash. you have to set proxy env variables first.
	// urls, err := GetDuckImageUrls(place)

	urls, err := GetUnsplashImageURLs(result)

	if len(urls) > 2 {
		s.cacher.SetArr(imagePlaceCacheKey, urls)
	}

	if err != nil {
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &PlaceImageResponse{ImageUrls: urls}, nil
}

func (s *server) GetCurrentVersion(con context.Context, req *GetCurrentVersionRequest) (*GetCurrentVersionResponse, error) {
	return &GetCurrentVersionResponse{Version: "1.0.0"}, nil
}
func (s *server) Ping(con context.Context, req *PingRequest) (*PingResponse, error) {
	return &PingResponse{}, nil
}

func parseMessage(message string) []*TravelPlace {
	lines := strings.Split(message, "\n")
	var places []*TravelPlace

	for _, line := range lines {
		if strings.HasPrefix(line, "-") {
			regex := regexp.MustCompile(`^-(.*):(.*)$`)
			match := regex.FindStringSubmatch(line)

			if len(match) > 0 {
				title := strings.TrimSpace(match[1])
				description := strings.TrimSpace(match[2])

				place := &TravelPlace{Title: title, Description: description}
				places = append(places, place)
			}
		}
	}

	return places
}

func (s *server) mustEmbedUnimplementedTravelSuggestionServer() {}
func (s *server) mustEmbedUnimplementedAuthServer()             {}
func (s *server) mustEmbedUnimplementedPlaceDetailsServer()     {}
func (s *server) mustEmbedUnimplementedPaymentServer()          {}
func (s *server) mustEmbedUnimplementedGeneralServer()          {}

func waitForDB() *gorm.DB {

	maxAttempts := 10
	for attempt := 1; attempt <= maxAttempts; attempt++ {
		db, err := ConnectDB(DBConnection{
			host:     os.Getenv("POSTGRES_ADDRESS"),
			user:     os.Getenv("POSTGRES_USER"),
			pass:     os.Getenv("POSTGRES_PASSWORD"),
			dbName:   os.Getenv("POSTGRES_USER"),
			port:     os.Getenv("POSTGRES_PORT"),
			sslmode:  false,
			timeZone: "Asia/Kolkata",
		})

		if err != nil {
			fmt.Println("Failed to connect to the database, retrying...")
			time.Sleep(2 * time.Second)
			continue
		}

		fmt.Println("Successfully connected to the PostgreSQL database!")
		return db
	}

	panic(fmt.Sprintf("Failed to connect to the database with %d retry", maxAttempts))

}

func NewServerImpl() *server {
	stripe.Key = os.Getenv("STRIPE_API_KEY")

	db := waitForDB()

	err := db.AutoMigrate(&AppUser{}, &UserPayment{})

	if err != nil {
		panic(fmt.Sprintf("Failed to migrate db database; %v", err))
	}

	cacher, err := NewCacher()

	if err != nil {
		panic(fmt.Sprintf("Failed to connect to the cacher: %v\n", err))

	}

	return &server{
		limiter: NewRateLimiter(),
		db:      db,
		cacher:  cacher,
	}
}

func getStreamChat(prompt string) (*openai.ChatCompletionStream, error) {
	client := openai.NewClient(os.Getenv("OPENAI_API_KEY_API_KEY"))

	stream, err := client.CreateChatCompletionStream(
		context.Background(),
		openai.ChatCompletionRequest{
			Model: openai.GPT3Dot5Turbo,
			Messages: []openai.ChatCompletionMessage{
				{
					Role:    openai.ChatMessageRoleUser,
					Content: prompt,
				},
			},
			Stream: true,
		},
	)
	if err != nil {
		return nil, err
	}

	return stream, nil
}
