FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive

# apt-utils seems missing and warnings are shown, so we install it.
# We have to fix libc-bin not to segfault while building Docker image on arm64 in QEMU.
RUN apt-get update -q -q && \
  mv /var/lib/dpkg/info/libc-bin.* /tmp/ && /
  dpkg --remove --force-remove-reinstreq libc-bin && \
  dpkg --purge libc-bin && \
  apt-get install --yes --force-yes  install libc-bin && \
  mv /tmp/libc-bin.* /var/lib/dpkg/info/ && \
  apt-get install --yes --force-yes apt-utils tzdata locales file sudo gnupg && \
  locale-gen --no-purge en_US.UTF-8 && \
  update-locale LANG=en_US.UTF-8 && \
  echo locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8 | debconf-set-selections && \
  echo locales locales/default_environment_locale select en_US.UTF-8 | debconf-set-selections && \
  dpkg-reconfigure locales && \
  echo 'UTC' > /etc/timezone && \
  rm /etc/localtime && \
  dpkg-reconfigure tzdata && \
  apt-get upgrade --yes --force-yes && \
  rm -f /etc/cron.*/* && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

ENV LC_ALL en_US.UTF-8
