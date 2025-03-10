# Build stage
FROM golang:1.24-alpine AS builder
WORKDIR /app

# Copy and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire source code
COPY . .

# Build the application
RUN go build -o sre-challenge ./cmd/main.go

# Runtime stage
FROM alpine:latest
WORKDIR /root/

# Copy the built binary and config directory
COPY --from=builder /app/sre-challenge .
COPY --from=builder /app/config ./config/

# Expose the application port
EXPOSE 3000

# Run the application
CMD ["./sre-challenge"]
