#!/bin/bash

docker rm -f ffdobuild
docker build -t ffdobuild .
docker run --name ffdobuild ffdobuild
