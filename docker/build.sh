#!/bin/bash

set -x -e

# Clean up
rm -rf gluon
git clone https://github.com/freifunk-gluon/gluon.git gluon -b "${GLUON_TAG}"

# Add site configuration
mkdir -p gluon/site
cp /usr/src/site.mk gluon/site/
cp /usr/src/site.conf gluon/site/

# Build
cd gluon
make update
time make -j 5 GLUON_TARGET=ar71xx-generic

set +x
echo -e "\nBUILD FINISHED\n"
echo "You can copy the resulting images from the conatiner using:"
echo -e "\ndocker cp ${HOSTNAME}:/usr/src/build/gluon/images <destination>\n"
