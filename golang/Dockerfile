# BASE DOCKER IMAGE DOCKERFILE:
# https://github.com/docker-library/golang/blob/349270dbc128e396888cb2423ffc85d2c3039a27/1.7/alpine/Dockerfile
FROM golang:1.7-alpine

COPY . /code
WORKDIR /code

RUN go get golang.org/x/crypto/bcrypt
RUN go build ./app.go

CMD ["./app"]
