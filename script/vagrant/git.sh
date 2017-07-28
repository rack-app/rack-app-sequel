#!/bin/bash

GIT_FLAG=$FLAG_FOLDER/git

if [ ! -f $GIT_FLAG ];then
    sudo apt-get install -y git

    touch $GIT_FLAG
fi
