FROM golang:1.21 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN build -o main . 

#------------------DISTROSSLESS IMAGE - -----------
FROM gcr.io/DISTROSSLESS/base
COPY --from base /app/main .
COPY -from=base /app/static ./static
EXPOSE 8090
cmd["./main"]