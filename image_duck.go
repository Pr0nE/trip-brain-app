package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	urls "net/url"
	"os"
	"regexp"
	"strings"
)

type SearchResult struct {
	Results []ImageResult `json:"results"`
}

type ImageResult struct {
	Image string `json:"image"`
	URL   string `json:"url"`
}

func GetDuckImageUrls(query string) ([]string, error) {
	vqd, err := getVQD(query)

	if err != nil {
		return nil, err
	}

	response, err := getSearchResults(vqd, query)

	if err != nil {
		return nil, err
	}

	return extractImages(response)

}

func getSearchResults(vqd string, query string) ([]byte, error) {
	formattedPlace := strings.ReplaceAll(query, " ", "+")
	url := fmt.Sprintf("https://duckduckgo.com/i.js?l=us-en&o=json&q=%s&vqd=%s", formattedPlace, vqd)
	return getUrl(url, true, 0)
}

func getUrl(url string, useProxy bool, retried int) ([]byte, error) {
	const maxRetry = 5
	client := &http.Client{}

	if useProxy {
		proxyURL := &urls.URL{
			User: urls.UserPassword(os.Getenv("PROXY_SERVER_USER"), os.Getenv("PROXY_SERVER_PASS")),
			Host: os.Getenv("PROXY_SERVER"),
		}

		transport := &http.Transport{
			Proxy: http.ProxyURL(proxyURL),
		}

		client.Transport = transport
	}

	response, err := client.Get(url)

	if err != nil {
		if retried < maxRetry {
			return getUrl(url, useProxy, retried+1)
		}

		return nil, err
	}
	defer response.Body.Close()

	body, err := io.ReadAll(response.Body)
	if err != nil {
		return nil, err
	}

	return body, nil
}

func getVQD(query string) (string, error) {
	formattedPlace := strings.ReplaceAll(query, " ", "+")
	url := fmt.Sprintf("https://duckduckgo.com/?va=v&t=ha&q=%s&iax=images&ia=images", formattedPlace)
	resp, err := getUrl(url, true, 0)

	os.WriteFile("test.txt", resp, 0644)

	if err != nil {
		return "", err
	}

	return extractVQD(string(resp))
}

func extractVQD(input string) (string, error) {
	regex := regexp.MustCompile(`vqd="([^"]+)"`)

	match := regex.FindStringSubmatch(input)
	if len(match) != 2 {
		return "", fmt.Errorf("no vqd value found in the URL")
	}

	return match[1], nil
}

func extractImages(input []byte) ([]string, error) {
	var result SearchResult

	err := json.Unmarshal(input, &result)
	if err != nil {
		return nil, err
	}

	var images []string
	for i, image := range result.Results {
		if i >= 5 {
			break
		}
		images = append(images, string(image.Image))
	}

	return images, nil
}
