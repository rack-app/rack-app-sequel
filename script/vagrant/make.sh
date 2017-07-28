#!/bin/bash

MAKE_FLAG=$FLAG_FOLDER/make
if [ ! -f $MAKE_FLAG ];then
    apt-get -y install make
    touch $MAKE_FLAG
fi
