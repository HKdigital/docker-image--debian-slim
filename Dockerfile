# ........................................................................ About
#
# @see README at https://github.com/HKdigital/docker-images--debian-slim
#

# ......................................................................... FROM

FROM debian:bullseye-slim

MAINTAINER Jens Kleinhout "hello@hkdigital.nl"

# .......................................................................... ENV

# Update the timestamp below to force an apt-get update during build
ENV APT_SOURCES_REFRESHED_AT 2022-08-21_16h16

# ........................................................ Install default tools

RUN apt-get -qq update && \
    apt-get -qq -y install \
      nano telnet iproute2 iputils-ping curl wget \
      tar unzip rsync sudo procps gnupg dumb-init > /dev/null

# ...................................................................... WORKDIR

WORKDIR /srv

# ............................................................. ENTRYPOINT & CMD

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/srv/run.sh"]
