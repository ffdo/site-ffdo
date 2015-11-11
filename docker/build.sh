#!/bin/bash

set -x -e

# Clean up
rm -rf gluon
git clone https://github.com/freifunk-gluon/gluon.git gluon -b "${GLUON_TAG}"

# Add site configuration
mkdir -p gluon/site
cp /usr/src/site.mk gluon/site/
cp /usr/src/site.conf gluon/site/
cp -r /usr/src/i18n gluon/site/

# Build
cd gluon
make update
time make -j $(($(nproc)+1)) V=s BROKEN=1 GLUON_TARGET=ar71xx-generic

set +x
echo -e "\nBUILD FINISHED\n"
echo "You can copy the resulting images from the container using:"
echo -e "\ndocker cp ${HOSTNAME}:/usr/src/build/gluon/images <destination>\n"
