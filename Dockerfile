FROM debian:jessie
MAINTAINER Markus Lindenberg <markus@lindenberg.io>

ENV GLUON_TAG v2015.1

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update
RUN apt-get -y install --no-install-recommends ca-certificates python wget file git subversion build-essential gawk unzip libncurses5-dev zlib1g-dev && apt-get clean


ADD docker/build.sh /usr/src/build.sh
ADD site.mk /usr/src/site.mk
ADD site.conf /usr/src/site.conf

RUN adduser --system --home /usr/src/build build
USER build
WORKDIR /usr/src/build
RUN git config --global user.email "technik@freifunk-dortmund.de"
RUN git config --global user.name "FFDO Gluon Build System"

CMD ["/usr/src/build.sh"]
