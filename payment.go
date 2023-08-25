package main

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"os"

	"github.com/stripe/stripe-go"
	"github.com/stripe/stripe-go/paymentintent"
	"github.com/stripe/stripe-go/webhook"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

func (s *server) FetchPrices(con context.Context, req *FetchPricesRequest) (*FetchPricesResponse, error) {
	return &FetchPricesResponse{
		Prices: []*SuggestionPrice{
			{
				Price:            2.5,
				SuggestionAmount: 10,
			},
			{
				Price:            5,
				SuggestionAmount: 25,
			},
			{
				Price:            10,
				SuggestionAmount: 60,
			},
		},
	}, nil
}

func (s *server) BuyCredit(con context.Context, req *BuyCreditRequest) (*BuyCreditResponse, error) {

	token := req.GetToken()
	amount := int64(req.GetAmount())
	currency := "USD"

	userId, err := CheckAccessToken(token)

	if err != nil {
		fmt.Print(err)
		return nil, status.Error(codes.Unauthenticated, err.Error())
	}

	priceInUSD := amount / 10
	priceInUSDCents := priceInUSD * 100

	intent, err := GetNewIntent(priceInUSDCents, currency)

	if err != nil {
		fmt.Print(err)
		return nil, status.Error(codes.Internal, err.Error())
	}

	params := SavePaymentParams{
		ID:     intent.ID,
		Amount: int32(amount),
		UserID: userId,
	}

	err = SavePayment(params, s.db)

	if err != nil {
		fmt.Print(err)
		return nil, status.Error(codes.Internal, err.Error())
	}

	return &BuyCreditResponse{ClientSecret: intent.ClientSecret}, nil
}

func GetNewIntent(amount int64, currency string) (*stripe.PaymentIntent, error) {
	stripe.Key = os.Getenv("STRIPE_API_KEY")

	params := &stripe.PaymentIntentParams{
		Amount:   stripe.Int64(amount),
		Currency: stripe.String(currency),
		PaymentMethodTypes: stripe.StringSlice([]string{
			"card",
		}),
	}

	intent, err := paymentintent.New(params)

	return intent, err
}

func HandleStripeWebhook(w http.ResponseWriter, req *http.Request, onSuccessIntent func(intentId string, amount int)) {
	const MaxBodyBytes = int64(65536)
	req.Body = http.MaxBytesReader(w, req.Body, MaxBodyBytes)
	payload, err := io.ReadAll(req.Body)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading request body: %v\n", err)
		w.WriteHeader(http.StatusServiceUnavailable)
		return
	}

	endpointSecret := os.Getenv("STRIPE_WEBHOOK_SECRET")

	event, err := webhook.ConstructEvent(payload, req.Header.Get("Stripe-Signature"),
		endpointSecret)

	if err != nil {
		fmt.Fprintf(os.Stderr, "Error verifying webhook signature: %v\n", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	switch event.Type {
	case "payment_intent.succeeded":

		data := event.Data.Object
		id := data["id"].(string)
		amountReceived := data["amount_received"].(float64)

		onSuccessIntent(id, int(amountReceived))

	default:
		fmt.Fprintf(os.Stderr, "Unhandled event type: %s\n", event.Type)
	}

	w.WriteHeader(http.StatusOK)
}

func ConvertPaymentAmountToBalance(amount int32) (int32, error) {

	return amount * 10, nil

}
