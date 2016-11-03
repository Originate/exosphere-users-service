#!/bin/bash

mkdir -p /var/log/
/usr/bin/mongod --fork --logpath /var/log/mongod.log

sleep 20s

exo-js
