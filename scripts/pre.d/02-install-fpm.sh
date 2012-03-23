#!/bin/bash
#### DON NOT EDIT THIS SCRIPT CREATE NEW SCRIPTS AS DESCRIBED IN THE DOCS ####

# Script to install latest stable php5-fpm and deps

apt-get update
apt-get install -y python-software-properties

echo "Installing PHP5 FPM"
echo "II: Adding repository ppa:fabianarias/php5"
apt-add-repository ppa:brianmercer/php

echo "II: Updating repo cache"
export DEBIAN_FRONTEND=noninteractive
aptitude -y update

echo "II: Installing php-fpm"
aptitude -y install php5-fpm php5-curl php5-cli php5-common php5-mysql php-apc

