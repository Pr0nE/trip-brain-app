package main

import (
	"context"
	"errors"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/dgrijalva/jwt-go"
	"google.golang.org/api/idtoken"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

func (s *server) TokenAuthorize(con context.Context, req *TokenAuthorizeRequest) (*TokenAuthorizeResponse, error) {
	accessToken := req.GetToken()

	if accessToken == "guest" {
		balance, err := s.limiter.GetGuestUserBalance(con)
		if err != nil {
			return nil, status.Error(codes.PermissionDenied, err.Error())
		}

		return &TokenAuthorizeResponse{User: &User{Token: accessToken, Balance: balance}}, nil

	} else {
		userId, err := CheckAccessToken(accessToken)

		if err != nil {
			fmt.Print(err)
			return nil, status.Error(codes.Unauthenticated, err.Error())
		}

		user, err := GetUser(userId, s.db)

		if err != nil {
			fmt.Print(err)
			return nil, status.Error(codes.Internal, "Failed to check user balance")
		}

		return &TokenAuthorizeResponse{User: &User{Id: user.ID, Token: accessToken, Balance: user.Balance, Name: user.Name}}, nil
	}

}
func (s *server) SocialAuthorize(con context.Context, req *SocialAuthorizeRequest) (*SocialAuthorizeResponse, error) {
	token := req.GetToken()
	provider := req.GetProvider()
	if provider == "google" {
		payload, err := VerifyGoogleAccessToken(token)

		if err != nil {
			return nil, err
		}

		info := payload.Claims

		userId, ok := info["aud"].(string)
		if !ok {
			return nil, errors.New("Invalid User ID")
		}

		name, ok := info["given_name"].(string)
		if !ok {
			name = ""
		}

		token, err := GenerateJWTToken(userId)

		if err != nil {
			return nil, err
		}

		user, err := UserExists(userId, s.db)

		if user == nil {
			user, err = AddUser(userId, name, s.db)
			if err != nil {
				return nil, err
			}
		}

		return &SocialAuthorizeResponse{User: &User{Id: userId, Name: name, Token: token, Balance: user.Balance}}, nil
	}

	return nil, errors.New("Unsupported provider")

}

func VerifyGoogleAccessToken(token string) (*idtoken.Payload, error) {
	ctx := context.TODO()

	aud := os.Getenv("GOOGLE_CLIENT_ID")

	payload, err := idtoken.Validate(ctx, token, aud)
	if err != nil {
		log.Printf("Google access token validation failed: %v", err)
		return nil, err
	}

	return payload, nil
}

func GenerateJWTToken(userId string) (string, error) {
	secretKey := os.Getenv("JWT_SECRET")

	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)
	claims["userId"] = userId
	claims["exp"] = time.Now().Add(time.Hour).Unix()

	tokenString, err := token.SignedString([]byte(secretKey))
	if err != nil {
		return "", err
	}

	return tokenString, nil
}

func CheckAccessToken(accessToken string) (string, error) {
	secretKey := os.Getenv("JWT_SECRET")

	token, err := jwt.Parse(accessToken, func(token *jwt.Token) (interface{}, error) {
		// Verify the signing method of the token
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("invalid signing method: %v", token.Header["alg"])
		}

		return []byte(secretKey), nil
	})

	if err != nil {
		return "", err
	}

	if !token.Valid {
		return "", fmt.Errorf("invalid token")
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return "", fmt.Errorf("invalid token claims")
	}

	expirationTime := time.Unix(int64(claims["exp"].(float64)), 0)
	if time.Now().After(expirationTime) {
		return "", fmt.Errorf("token has expired")
	}

	userId, ok := claims["userId"].(string)

	if !ok {
		return "", fmt.Errorf("invalid token claims: userId")
	}
	return userId, nil
}
