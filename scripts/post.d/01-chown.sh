#!/bin/bash

# chown the webroot and cache directors so nginx can access them
chown -Rf www-data.www-data /var/www/
chown -Rf www-data.www-data /mnt/www/
