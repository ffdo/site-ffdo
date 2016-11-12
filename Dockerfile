FROM debian:jessie
MAINTAINER Markus Lindenberg <markus@lindenberg.io>

ENV GLUON_SITE ffdo
ENV GLUON_TAG v2016.2.1
ENV GLUON_RELEASE 0.10.0
ENV GLUON_BRANCH stable
ENV GLUON_BROKEN 1
ENV GLUON_TARGETS ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-64 brcm2708-bcm2708 brcm2708-bcm2709

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update
RUN apt-get -y install --no-install-recommends ca-certificates python python3 wget file git subversion build-essential gawk unzip libncurses5-dev zlib1g-dev openssl libssl-dev bsdmainutils && apt-get clean

ADD docker-build.py /usr/src/build.py
ADD site.mk /usr/src/site.mk
ADD site.conf /usr/src/site.conf
ADD i18n /usr/src/i18n

RUN adduser --system --home /usr/src/build build
USER build
WORKDIR /usr/src/build
RUN git config --global user.email "technik@freifunk-dortmund.de"
RUN git config --global user.name "FFDO Gluon Build Container"

CMD ["/usr/src/build.py"]

