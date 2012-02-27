#!/bin/bash

echo "### Bouncing services ###"

/etc/init.d/nginx restart
/etc/init.d/php5-fpm restart
