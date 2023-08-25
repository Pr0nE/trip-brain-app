package main

import (
	"fmt"
	"image"
	"image/jpeg"
	"image/png"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/nfnt/resize"
)

func CompressImage(url string, maxWidth, maxHeight uint) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Create a file to store the downloaded image
	fileName := filepath.Base(url)
	file, err := os.Create(fileName)
	if err != nil {
		return err
	}
	defer file.Close()

	// Copy the downloaded image to the file
	_, err = io.Copy(file, resp.Body)
	if err != nil {
		return err
	}

	// Open the downloaded image file
	imageFile, err := os.Open(fileName)
	if err != nil {
		return err
	}
	defer imageFile.Close()

	// Decode the image file
	img, format, err := image.Decode(imageFile)
	if err != nil {
		return err
	}

	// Resize the image
	resizedImg := resize.Resize(maxWidth, maxHeight, img, resize.Lanczos3)

	// Save the compressed image
	compressedFile, err := os.Create("compressed_" + fileName)
	if err != nil {
		return err
	}
	defer compressedFile.Close()

	// Encode the resized image based on the image format and write it to the compressed file
	switch strings.ToLower(format) {
	case "jpeg", "jpg":
		err = jpeg.Encode(compressedFile, resizedImg, nil)
	case "png":
		err = png.Encode(compressedFile, resizedImg)
	default:
		return fmt.Errorf("Unsupported image format: %s", format)
	}
	if err != nil {
		return err
	}

	return nil
}
