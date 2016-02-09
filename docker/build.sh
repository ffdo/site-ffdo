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
make clean
time make -j $(($(nproc)+1)) V=s BROKEN=1 GLUON_TARGET=ar71xx-nand
make clean
time make -j $(($(nproc)+1)) V=s BROKEN=1 GLUON_TARGET=mpc85xx-generic
make clean
time make -j $(($(nproc)+1)) V=s BROKEN=1 GLUON_TARGET=x86-generic
make clean
time make -j $(($(nproc)+1)) V=s BROKEN=1 GLUON_TARGET=x86-64
make clean

set +x
echo -e "\nBUILD FINISHED\n"
echo "You can copy the resulting images from the container using:"
echo -e "\ndocker cp ${HOSTNAME}:/usr/src/build/gluon/output <destination>\n"
