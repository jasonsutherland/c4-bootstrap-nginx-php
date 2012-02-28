#c4-bootstrap-php

A simple way to deploy a NGINX + PHP5-FPM environment to replicate a channel4.com microsite, for testing your deploys.

##HOWTO c4-bootstrap

1. Start your Ubuntu 10.04 LTS Server.

2. Install git so you can clone the repository:

```bash
sudo apt-get update
sudo apt-get install git-core
```

3. Clone the c4-bootstrap-php repo onto your server:

```bash
git clone https://github.com/channel4/c4-bootstrap.git
```

4. Now run the bootstrap script to set up the environment:

```bash
cd c4-bootstrap-php
sudo ../bootstrap.sh
```

5. Now you can make changes to the system by following the working directories and scripting guides.

##HOWTO c4-repack


##Working Directories

c4-bootstrap-php is set up to monitor changes you make to the following folders and helps you package up the system for delivery to channel4. If you're going to make any changes outside these directories please get in touch with the project manager and ask to set up a technical conference call.

###/var/www/public/

This is your web root so should be the location of everything you wish NGINX to server. PHP files will be processed by PHP5-FPM

###/var/www/private/

We recomend you use this location to store scripts that do not need to be public facing, for example this may be a script that is called by cron to pull data from another location before processing it and putting it into a database. If the general public do not need to hit these files through a browser put the files here.

###/etc/cron.d/

This is the default location for all your cron jobs.

###/etc/nginx/

Any tweaks to the NGINX settings are made here. There is also a example HTTPS config int he default file.

###/etc/php5/

You can tweak php.ini here, as this setup uses fpm please edit the file in **/etc/php5/fpm/**

##Scripting
If you wish to install new dependancies or preform extra options on the server at boottime we recomend you build a script. For installing new dependancies using apt-get the use **~/c4-bootstrap-php/scripts/pre.d/** folder and then re-run **./bootstrap.sh**. Doing this will ensure that when a clean system is built the dependancies get installed at bootstrap. If you wish to preform actions on files after your environment is setup use the **~/c4-bootstrap-php/scripts/post.d/** folder.

An example script to install new packages would be:

```bash
#!/bin/bash
# example install deps script

# always good to update the repo first
apt-get update

# now install the packages you need and use -y for non interactive install
apt-get install -y vim vim-scripts

```
