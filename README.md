#c4-bootstrap-nginx-php

This project provides a simple way to deploy a NGINX + PHP5-FPM environment and save your code with version control. It uses the c4-bootstrap lightweight system management tools.


##Requirements

You will need to install:

    git-core

To do so, run:

    apt-get update
    apt-get install git-core

These standard toolkits should also be present on the system:

    bash
    tar
    gzip


##HOWTO bootstrap

Bootstraping your server will install the requested environment on your sysetm.

Fire up your Ubuntu server or Ubuntu AMI EC2 instance. These scripts are designed to work on Ubuntu 10.04 LTS. Please see c4-bootstrap documentation for further information on compatibility and the deployment framework in general.

To get started, fork this git repo and clone onto the fresh server:

    First click the fork button on the this github page
    You'll need a github account to do this

We recomend you have a paid account so you can keep your code private.

Optional: You can rename your fork to represent the project you are working on. If you do you will have to change the lines below to reflect your new repo name.

On the server CLI:

    git clone https://github.com/*<USERNAME>*/c4-bootstrap-nginx-php.git
    cd c4-bootstrap-nginx-php
    sudo ./bootstrap.sh

There should be considerable output on screen. Once the script has finished, the system should be fully up and running.

If you have never run repack.sh before (see c4-bootstap documentation), when you browse to your URL/IP you will see a 403 access denied error browser side. 

If you have been using repack.sh to track your changes in github then your site will be fully restored and running when you browse to your URL/IP.
bootstraping your server will install the requested environment on your sysetm.

##HOW TO repack

While developing your site the contents of the site may change frequently. repack.sh is designed to help you track those changes in github and all you to rebuild the server to a given point in time. Its good practice to use repack.sh regularly to avoid loss of work, especially if you frequently add content to your site.

Simply run these commands (remember to reflect repo name if changed):

    cd c4-bootstrap-nginx-php
    sudo ./repack.sh

This will create a SiteContent.tgz of your site and push them back to your github repo. It can be used to back up your site or even redeploy your site on a new server using the bootstrap.sh script. 

c4-bootstrap-nginx-php is set up to monitor the following directories:

    /etc/nginx/
    /etc/php5/
    /var/www/

Changes in these directories will be pulled back into your git repo when running repack. To add more locations just edit the __scripts/repack/working_dirs__ file.

NB : You should set your github repo to private to avoid exposing your private code and configs to everyone!

##More info

For more info on c4-bootstrap please refer to:

[https://github.com/channel4/c4-bootstrap/blob/master/README.md](https://github.com/channel4/c4-bootstrap/blob/master/README.md "c4-bootstrap README")
