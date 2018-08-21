FROM alpine:3.8

RUN apk update && \ 
 echo 'UTC' > /etc/timezone && \
 apk add sudo zdata file bash
