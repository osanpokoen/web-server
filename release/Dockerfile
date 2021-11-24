FROM golang:1.17.3 as builder
WORKDIR /go/src/app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM scratch as runner
LABEL maintainer="kakitamama"

EXPOSE 3000
COPY --from=builder /go/src/app/server /server
CMD ["/server"]
