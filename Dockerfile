# from ubuntu 16.04:
FROM ubuntu:16.04

# make instalation direcory
RUN mkdir /wkhtmltox_instalation

# change working direcotry to it
WORKDIR /wkhtmltox_instalation

# copy instalation files
COPY files/wkhtmltox_instalation.tar.xz /wkhtmltox_instalation/

# install dependencies
RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends xz-utils fontconfig libxrender1 xfonts-base xfonts-75dpi libxext6 \
  && apt-get autoremove -yqq \
  && apt-get clean -yqq \
  && rm -rf /var/lib/apt/lists/*

# install wkhtmltox and remove instalation file from container
RUN tar vxfJ wkhtmltox_instalation.tar.xz \
  && rm wkhtmltox_instalation.tar.xz
