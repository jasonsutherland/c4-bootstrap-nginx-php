#!/bin/bash
#### DON NOT EDIT THIS SCRIPT CREATE NEW SCRIPTS AS DESCRIBED IN THE DOCS ####

# Script to install latest stable nginx on 10.04

echo "Installing Latest NGINX"
echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu lucid main" > /etc/apt/sources.list.d/nginx-stable-lucid.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
apt-get update
apt-get install -y nginx

