#!/bin/bash

if [ ! -f $FLAG_FOLDER/pg ];then
    sudo -u postgres psql -c "CREATE USER vagrant with PASSWORD 'vagrant';"
    sudo -u postgres psql -c "CREATE DATABASE vagrant;"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE vagrant to vagrant;"
    touch $FLAG_FOLDER/pg
fi