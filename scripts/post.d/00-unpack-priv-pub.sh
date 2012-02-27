#!/bin/bash
#### DON NOT EDIT THIS SCRIPT CREATE NEW SCRIPTS AS DESCRIBED IN THE DOCS ####

# If this is an completed ENV these files will contain the content of /var/www/[private|public] and need unpacking

for i in SiteContent.tgz ENV.tgz ; do
    if [ -f ${i} ]
    then
    echo "### Unpacking previous content ###"
        if [[ ${i} == "SiteContent.tgz" ]]; then STATIC_DIR=/var/www/public/ ; fi
        if [[ ${i} == "ENV.tgz" ]]; then STATIC_DIR=/var/www/private/ ; fi
        tar xvfz /var/tmp/c4-bootstrap-php/${i} -C ${STATIC_DIR}
    fi ;
done
