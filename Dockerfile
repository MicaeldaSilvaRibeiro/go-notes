# Stage 1: Build
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy && go build -o go-notes

# Stage 2: Runtime
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-notes .
COPY --from=builder /app/website ./website
EXPOSE 8080
CMD ["./go-notes"]
