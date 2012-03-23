#c4-bootstrap-nginx-php

A simple way to deploy a NGINX + PHP5-FPM environment and save your code with version control, using c4-bootstrap lightweight system management tools.

##Requirements

You'll need to install:

    git-core

You can do this with:

    apt-get update
    apt-get install git-core

These should be standard:

    bash
    tar
    gzip


##HOWTO bootstrap

bootstraping your server will install the requested environment on your sysetm.

Fire up your Ubuntu server or EC2 instance. These scripts are designed to work on Ubuntu 10.04 LTS!!!!

Now fork this git repo and clone onto your new server:

    First click the fork button on the this github page
    You'll need a github account to do this

We recomend you have a paid account so you can keep your code private.

You can also rename your fork to represent the project you are working on. If you do you'll have to slightly change the lines below to match your repo name.

On your new server:

    git clone https://github.com/*<USERNAME>*/c4-bootstrap-nginx-php.git
    cd c4-bootstrap-nginx-php
    sudo ./bootstrap.sh

You'll see lots of text fly past the screen as the system is setup. Once complete it should be fully up and running.

If you have never run repack.sh before, when you browse to your URL/IP you'll see an 403 access denied error in the browser. If you've been using repack.sh to track your changes in github then your site will be fully restored and running when you browse to your URL/IP.

##HOWTO repack

While developing your site the contents of the site may change frequently. repack.sh is designed to help you track those changes in github and all you to rebuild the server to a given point in time. Its good practice to use repack.sh regularly to avoid loss of work.

Simply run these commands (remember if you've renamed your rep change these commands):

    cd c4-bootstrap-nginx-php
    sudo ./repack.sh

This will create a SiteContent.tgz of your site and push them back to your github repo. It can be used to back up your site or even redeploy your site on a new server using the bootstrap.sh script. I recommend you back up regularly if you frequently add content to your site.

c4-bootstrap-nginx-php is set up to monitor the following directories:

    /etc/nginx/
    /etc/php5/
    /var/www/

Changes in these directories will be pulled back into your git repo when running repack. To add more locations just edit the __scripts/repack/working_dirs__ file.

NB : You should set your github repo to private to avoid exposing your private code and configs to everyone!

##More info

For more info on c4-bootstrap please refer to:

[https://github.com/channel4/c4-bootstrap/blob/master/README.md](https://github.com/channel4/c4-bootstrap/blob/master/README.md "c4-bootstrap README")
