# Usamos a versão 1.24 para coincidir com o teu go.mod
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy && go build -o main .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/templates ./templates
EXPOSE 8080
CMD ["./main"]
