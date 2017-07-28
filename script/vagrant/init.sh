#!/bin/bash

apt-get update > /dev/null
export FLAG_FOLDER="/home/vagrant/.installs"

if [ ! -d $FLAG_FOLDER ];then
    mkdir -p $FLAG_FOLDER
fi
