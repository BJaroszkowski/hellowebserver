FROM bombardier:base

COPY go.mod go.sum main.go /helloworld/
WORKDIR /helloworld

CMD ["bash", "-c", "go run main.go"]