package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
)

type ImageResponseModel struct {
	Results []Results `json:"results"`
}

type Results struct {
	Urls Urls `json:"urls"`
}

type Urls struct {
	Raw     string `json:"raw"`
	Full    string `json:"full"`
	Regular string `json:"regular"`
	Small   string `json:"small"`
	Thumb   string `json:"thumb"`
	SmallS3 string `json:"small_s3"`
}

func GetUnsplashImageURLs(response []byte) ([]string, error) {
	var imageResponse ImageResponseModel
	err := json.Unmarshal(response, &imageResponse)
	if err != nil {
		return nil, err
	}

	urls := make([]string, 0, len(imageResponse.Results))
	for _, result := range imageResponse.Results {
		urls = append(urls, result.Urls.Regular)
	}

	return urls, nil
}

func FetchResponse(place string) ([]byte, error) {
	formattedPlace := strings.ReplaceAll(place, " ", "+")
	url := "https://api.unsplash.com/search/photos?query=" + formattedPlace + "&page=1"

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, err
	}

	authHeader := fmt.Sprintf("Client-ID %s", os.Getenv("UNSPLASH_API_KEY"))

	req.Header.Add("Authorization", authHeader)

	client := http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	return body, nil
}
