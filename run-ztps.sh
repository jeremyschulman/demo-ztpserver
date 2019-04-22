#!/bin/bash

export ZTPS_DEFAULT_DATAROOT=${VIRTUAL_ENV}/lib/python2.7/site-packages/usr/share/ztpserver
ztps -c ztpserver.config --debug
