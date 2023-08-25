# Use the official Golang image to build the Go project
FROM golang:latest AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory's Go project to the container
COPY . .

# Build the Go project
RUN go build -o app

# Use a new stage to create the final minimal image
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built executable from the previous stage
COPY --from=builder /app/app .

# Copy the .env file to the container
COPY .env .

# Copy the certificates file to the container
COPY certs ./certs

EXPOSE 50051
EXPOSE 4242

# The command to start the Go application
CMD ["./app"]
