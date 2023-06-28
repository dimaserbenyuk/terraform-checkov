
FROM golang:1.20.5-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY main.go main.go

RUN go build -o /myapp main.go

FROM debian:stable


COPY --from=build /myapp /myapp

ENTRYPOINT ["/myapp"]