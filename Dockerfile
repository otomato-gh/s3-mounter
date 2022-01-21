FROM golang:1.13.15-alpine3.12 as builder
WORKDIR /build
ENV CGO_ENABLED=0
RUN apk add -U git
RUN git clone https://github.com/kahing/goofys.git . && \
    go build -ldflags "-X main.Version=`git rev-parse HEAD`"
FROM alpine:3.12
WORKDIR /otomato
COPY --from=builder /build/goofys .
CMD [./goofys]
