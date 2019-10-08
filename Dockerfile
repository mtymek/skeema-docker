FROM golang:1.13
RUN go get -d -v github.com/skeema/skeema
WORKDIR /go/src/github.com/skeema/skeema
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/skeema .

FROM alpine:latest
RUN mkdir /skeema
WORKDIR /skeema
#RUN apk --no-cache add ca-certificates
COPY --from=0 /go/bin/skeema /root/
ENTRYPOINT ["/root/skeema"]

