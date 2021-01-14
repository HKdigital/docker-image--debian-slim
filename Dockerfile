# ........................................................................ About

# This docker image basically is just the OS, with some minor tweaks:
# - Installs a few practical often used programs (e.g. by image installers)
# - Files and folders are copied from the folder "image-files"
# - Adds dump-init to prevent zombie processes when stopping containers
#
# Jens Kleinhout
# hkdigital.nl

# ......................................................................... FROM

FROM debian:buster-slim

MAINTAINER Jens Kleinhout "hello@hkdigital.nl"

# .......................................................................... ENV

# Update the timestamp below to force an apt-get update during build
ENV APT_SOURCES_REFRESHED_AT 2021-01-14_16h08

# ........................................................ Install default tools

RUN apt-get -qq update && \
    apt-get -qq -y install \
      nano telnet iproute2 iputils-ping curl wget \
      tar unzip rsync sudo procps gnupg > /dev/null

# ............................................................ COPY /image-files

# Copy files and folders from project folder "/image-files" into the image
# - The folder structure will be maintained by COPY
#
# @note
#    No star in COPY command to keep directory structure
#    @see http://stackoverflow.com/
#        questions/30215830/dockerfile-copy-keep-subdirectory-structure

# Update the timestamp below to force copy of image-files during build
ENV IMAGE_FILES_REFRESHED_AT 2021-01-14_16h08

COPY ./image-files/ /

# ............................................................ Install dumb-init

# Dumb init is a simple process supervisor and init system designed to run as
# PID 1 inside minimal container
#
# @see
#     https://github.com/
#       Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb

RUN dpkg -i /srv/install-packages/dumb-init_*.deb && \
    rm /srv/install-packages/dumb-init_*.deb

# ...................................................................... WORKDIR

WORKDIR /srv

# ............................................................. ENTRYPOINT & CMD

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/srv/run.sh"]
