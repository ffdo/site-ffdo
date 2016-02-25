#!/usr/bin/env python3

from os import environ, makedirs, chdir, listdir
from os.path import isdir
from subprocess import check_call
from shutil import *
from multiprocessing import cpu_count

# Clean up and clone gluon
if isdir('gluon'):
    rmtree('gluon')
check_call('git clone https://github.com/freifunk-gluon/gluon.git gluon -b "%s"' % environ['GLUON_TAG'], shell=True)

# Add site configuration
makedirs('gluon/site')
copy('/usr/src/site.mk', 'gluon/site')
copy('/usr/src/site.conf', 'gluon/site')
copytree('/usr/src/i18n', 'gluon/site/i18n')

# Prepare
chdir('gluon')
check_call('make update', shell=True)

# Choose targets to build
if 'GLUON_TARGETS' in environ:
    targets = environ['GLUON_TARGETS'].split()
else:
    targets = [f for f in listdir('targets') if isdir('targets/%s' % f)]

branch = environ['GLUON_BRANCH'] if 'GLUON_BRANCH' in environ else 'stable'
broken = environ['GLUON_BROKEN'] if 'GLUON_BROKEN' in environ else '0'

# Build
for target in targets:
    print('Building for target %s' % target)
    check_call('make -j %s GLUON_BRANCH=%s BROKEN=%s GLUON_TARGET=%s' % (cpu_count(), branch, broken, target), shell=True)
    check_call('make dirclean', shell=True)

check_call('make manifest GLUON_BRANCH=%s' % branch, shell=True)

print('''BUILD FINISHED
You can copy the resulting images from the container using:
docker cp %s:/usr/src/build/gluon/output <destination>'''% environ.get('HOSTNAME'))

