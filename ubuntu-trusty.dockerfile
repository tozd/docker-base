FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# apt-utils seems missing and warnings are shown, so we install it.
RUN apt-get update -q -q && \
 apt-get install --yes --force-yes apt-utils && \
 echo 'UTC' > /etc/timezone && \
 dpkg-reconfigure tzdata && \
 apt-get upgrade --yes --force-yes && \
 rm -f /etc/cron.weekly/fstrim
