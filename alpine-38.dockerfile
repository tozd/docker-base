FROM alpine:3.8

RUN apk update && \ 
 apk add sudo zdata file bash
