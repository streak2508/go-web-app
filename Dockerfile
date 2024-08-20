FROM golang:1.21 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main . 

#------------------DISTROSSLESS IMAGE - -----------
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
cmd [ "./main" ]
EXPOSE 8090