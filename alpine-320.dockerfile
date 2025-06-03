FROM alpine:3.20

# /etc/localtime is already configured to UTC.
RUN apk update && \
  apk upgrade && \
  apk add sudo file bash && \
  apk add cmake make musl-dev gcc gettext-dev libintl && \
  wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/1101fb2bcdd189cd9415b8bd1c775eb43527d25c/musl-locales-1101fb2bcdd189cd9415b8bd1c775eb43527d25c.tar.gz && \
  tar -xzf musl-locales-*.tar.gz && \
  cd musl-locales-* && \
  cmake -D LOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && \
  make && \
  make install && \
  cd .. && \
  rm -rf musl-locales-* musl-locales-*.tar.gz && \
  apk del cmake make musl-dev gcc gettext-dev && \
  echo 'UTC' > /etc/timezone && \
  rm -rf /var/cache/apk/*

ENV MUSL_LOCPATH /usr/share/i18n/locales/musl
ENV LC_ALL=en_US.UTF-8
