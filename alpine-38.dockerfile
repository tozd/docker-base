FROM alpine:3.8

# /etc/localtime is already configured to UTC.
RUN apk update && \
 apk upgrade && \
 apk add --no-cache cmake make musl-dev gcc libintl gettext-dev wget && \
 wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip && \
 unzip musl-locales-master.zip && \
 cd musl-locales-master && \
 cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && make && make install  && \
 cd .. && \
 rm -r musl-locales-master && \
 apk del cmake make gcc wget && \
 echo 'UTC' > /etc/timezone

ENV LC_ALL=en_US.UTF-8
