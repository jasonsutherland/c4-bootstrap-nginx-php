<<<<<<< HEAD
#c4-bootstrap-php

A simple way to deploy a NGINX + PHP5-FPM environment to replicate a channel4.com microsite, for testing your deploys. Built on c4-bootstrap lightweight systems management tool.

##HOWTO c4-bootstrap

* Start your Ubuntu 10.04 LTS Server.

* Install git so you can clone the repository:

```bash
sudo apt-get update
sudo apt-get install git-core
```

* Clone the c4-bootstrap-php repo onto your server:

```bash
git clone https://github.com/channel4/c4-bootstrap-php.git
```

* Now run the bootstrap script to set up the environment:

```bash
cd c4-bootstrap-php
sudo ./bootstrap.sh
```

* Now you can make changes to the system by following the working directories and scripting guides.

##HOWTO c4-repack

When your ready to commit your code to the channel4 git repo so you can either submit code to ISHosting or rebuild your server on another machine, first contact your project manager to start a conversation about getting a private github repo from us. This requires you having a github account and have your public SSH keys loaded into github and the private key on your test system in **~/.ssh/**. We'll then create a private repo for you and send you the details.

Change your repo details to the one supplied by Channel 4 Operations:

```bash
cd ~/c4-bootstrap-php
git config --global user.name "Firstname Lastname"
git config --global user.email "your_email@youremail.com"
```
You only need to do the following if you've cloned from c4-bootstrap-php master, if you've checked out your own repo this isn't needed:

**NOTE:** Swap MYREPO.git for the name supplied by Channel 4 Operations!

```bash
git push --mirror git@github.com:channel4/**MYREPO.git**
git remote set-url origin git@github.com:channel4/**MYREPO.git**
```

Once you've made changes to the system and created new scripts withing the bootstrap environment simply run the repack script. This will pull in files from your system into **~/c4-bootstrap-php/files/....** and package up any special directories like **/var/www/public|private** into tar.gz files.

```bash
sudo ./repack.sh
```

**NOTE:** If you are making future changes to the same website on a new server make sure you bootstrap from your new repo thus avoiding having to set everything up again:

```bash
git clone git@github.com:channel4/**MYREPO.git**
cd **MYREPO**
sudo ./bootstrap.sh
## Make your Changes
sudo ./repack.sh
```

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
If you wish to install new dependancies or preform extra actions on the server at boot time we recomend you build a script. For installing new dependancies using **apt-get** use **~/c4-bootstrap-php/scripts/pre.d/XX-mynewscript.sh** and then re-run **./bootstrap.sh** to install those dependancies. Doing this will ensure that when a clean system is built the dependancies get installed at bootstrap. If you wish to preform actions on files/folders or bounce a service after your environment is setup use the **~/c4-bootstrap-php/scripts/post.d/** folder.

An example script to install new packages would be:

```bash
#!/bin/bash
# example install deps script

# always good to update the repo first
apt-get update

# now install the packages you need and use -y for non interactive install
apt-get install -y vim vim-scripts

```
=======
#c4-bootstrap

A quick and lightweight configuration tool to build servers (cloud or real) to a consistent install level, provided by channel4.com.

##Concept

c4-bootstrap is designed to help you deploy repeatable physical or cloud servers using git as version control. When you build systems by hand there are normally three main stages. You start by installing the base packages, you then copy your files to the server and finally you tweak your config files. 

To replicate this we've developed the lightweight configuration package which consists of _scripts/pre.d_ which installs your base packages, the _files/_ directory which mimics the root of your server (For ease of use you should consider _files/_ as a mirror image of your _/_ directory) and is copied onto the system after _pre.d_ is run then the _scripts/post.d_ which you can use to configure your system.

We also provide a script called _repack.sh_, which enables you to pull changes you've made on your system back into the git repo to store for a later date. One thing you should note that if you install extra packages on your system via a package manager such as apt-get you need to update your install scripts in _scripts/pre.d_ so that when you rebuild a system all the requirements are there.

##Sub Projects

The main c4-bootstrap project is designed to be the basis for many sub projects that are far more complex. The core scripts can be reused and tracked by forking this project and we do accept pull requests for new features and bug fixes! If you have an interesting system build using c4-bootstrap please let us know and we'll list them on the wiki.

##Requirements

These scripts have only been tested on an Ubuntu based distro but should be easily altered to run elsewhere.

    git-core
    
You can install git on a fresh system by issuing these commands:

    sudo apt-get update
    sudo apt-get install git-core

These will be standard on most linux distro's:

    bash
    tar
    gzip

##HOWTO c4-bootstrap

Fire up your Ubuntu server or EC2 instance.

Now fork this git repo and clone onto your new server:

    First click the fork button on the c4-bootstrap github page
    
    Then using your details amend the following:
    
    git clone https://github.com/*<USERNAME>*/c4-bootstrap.git
    cd c4-bootstrap
    
Now keep track of upstream script changes:

    git remote add upstream git://github.com/channel4/c4-bootstrap.git
    git fetch upstream

Create some custom scripts to install software and prep the system in scripts/pre.d (make sure they are bash scripts)

Now populate files/ with any files you wish to be included on the system.

Finally you should now create your post file expansion tasks in scripts/post.d

If you now run ./bootstrap.sh you should see your actions being carried out on the server.

Don't forget to commit your changes back to git.

    git add *
    git commit -a
    git push origin master

Now one a fresh server you can simply:

    git clone https://github.com/<USERNAME>/c4-bootstrap.git
    ./bootstrap.sh

This will replicate your system onto the new server.

##HOWTO c4-repack

repack.sh is designed to help you manage servers that are already bootstraped. Once you have a bootstrapped server edit scripts/repack/00-suckfiles.sh and add more directories to the _working dirs()_ array. This will then allow the repack.sh script to copy these folders/files into the bootstrap files/ directory. On running repack.sh this will automatically copy your configured files into the system and commit them back to git.

##The System

###bootstrap.sh
bootstrap.sh allows you to quickly setup your system to specified environment, it will run pre.d and post.d scripts and also copy your directory structure from files to the root of the system. The following explains how the script works. The order of the system bootstrap is:

1. pre.d scripts are executed setting up your core components
2. files are then copied tot he root of your system
3. post.d scripts are then used to change configuration settings

####Environment checks
On running the bootstrap.sh scrip the system checks for the system distro name and the version. The version number can be tweaked at the top of the file by altering the following variable:

    supported_dist="Ubuntu"
    supported_vers="10.04"

To set the script to not copy files to the root directory change the following value to 0.

    prod=1

We currently track the LTS version of Ubuntu so the core scripts will soon change to 12.04 but they should work on any version.

####pre.d scripts
The script will then iterate through scripts/pre.d/XXXX and run each script in order. These are simply bash scripts to perform initial tasks such as install dependencies. An example script is provided. Scripts are run in order so 00-.... will be run before 01-....

####exploding files
This part of the script takes the contents of files/.... and copies them to / This allows you to include files such as a custom motd or something more useful like a sites-enabled config for nginx or apache. To set the script to not copy files to the root directory change the following value to 0 in this case the files will be copied to /tmp/c4-bootstrap.

    prod=0

####post.d
The final part of the script is post.d. This is called in the same way as pre.d and iterates through scripts/post.d/XXXX. In post.d you should run things that can only be done once the software is installed and the files are in place. An example of this would be _*a2ensite mysite.conf*_. Yet again these are bash scripts and will be run in numerical order.

###repack.sh
repack.sh allows you to commit local system changes back to a git repo in order repeat these changes on other servers.

####Environment checks
On running the repack.sh scrip the system checks for the system distro name and the version. The version number can be tweaked at the top of the file by altering the following variable:

    supported_dist="Ubuntu"
    supported_vers="10.04"

This ensures that you are packaging for the same version as the bootstrap.sh


####repack scripts
The repack scripts live in the scripts/repack directory. Care should be taken when editing current scripts or adding to this directory.
#####00-suckfiles.sh
suck files enables repack.sh to pull back into the local directory all the changes you've made on the system in specified directories. in the example script it purely backs up /var/www. It handles /var/www in a special way to compensate for the fact you may have a lot of files in that location by tar.gz the directory and storing it in files/var/tmp/SiteContent.tgz this is also referenced by bootstrap.sh and is exploded in post.d/00-explode-files.sh

Other directories specified are simply copied to files/....... verbatim.

You can add extra locations to be backed up by modifying the array below in scripts/repack/00-suckfiles.sh:

    working_dirs=( /var/www/ )

the folowing would also copy the contents of /etc/apache2/

    working_dirs=( /var/www/ /etc/apache2/ )

###Files

The file structure of the system is kept within files, this should be treated as a mirror of your root / for example files/etc/nginx/nginx.conf after bootstrap.sh is run will map to /etc/nginx/nginx.conf

>>>>>>> 8a96e7ac4ff1fa22cd4c442807d40f43ba03761a
