#!/usr/bin/env python3

import argparse
import time

parser = argparse.ArgumentParser(description='Combine multiple manifests into a new manifest')
parser.add_argument('-b', '--branch', default='stable', help='Branch name to set')
parser.add_argument('-p', '--priority', type=int, default=0, help='Priority to set')
parser.add_argument('manifest', nargs='+', help='Manifest files to include in output manifest')

def main():
    args = parser.parse_args()
    print('BRANCH=%s' % args.branch)
    offset = time.strftime('%z')
    print('DATE=%s' % time.strftime('%Y-%m-%d %H:%M:%S') + '%s:%s' % (offset[:-2], offset[3:]))
    print('PRIORITY=%d' % args.priority)
    print()

    for manifest in args.manifest:
        with open(manifest) as mfile:
            for line in mfile:
                if '=' in line:
                    continue
                l = line.strip()
                if l != '':
                    print(l)



if __name__ == '__main__':
    main()

