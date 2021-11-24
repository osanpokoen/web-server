FROM golang:1.17.3
LABEL maintainer="kakitamama"

WORKDIR /go/src/app
COPY . .

RUN go get github.com/pilu/fresh
CMD ["fresh"]
