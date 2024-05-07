#!/usr/bin/bash

GAMMA=$1
ONEMINUSGAMMA=$2

cp ../data/network_template.extnewick ../data/network.extnewick

sed -i -e "s/ONEMINUSGAMMA/$ONEMINUSGAMMA/g" ../data/network.extnewick
sed -i -e "s/GAMMA/$GAMMA/g" ../data/network.extnewick
