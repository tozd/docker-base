FROM alpine:3.8

ENV DEBIAN_FRONTEND noninteractive

# apt-utils seems missing and warnings are shown, so we install it.
RUN apk update && \ 
 echo 'UTC' > /etc/timezone && \
 apk add tzdata file bash && \
 rm /etc/localtime
