FROM alpine:3.8

# /etc/localtime is already configured to UTC.
RUN apk update && \ 
 apk upgrade && \
 apk add sudo file bash && \
 echo 'UTC' > /etc/timezone
