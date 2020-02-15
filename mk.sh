#!/bin/sh

OPTION=${1}
make -j2 ${OPTION} CC=distcc -f Build/Makefile.mak
