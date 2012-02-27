#c4-bootstrap

A quick and simple configuration tool to build servers (cloud or real) to a consitant install level, provided by channel4.com

These scripts have only been tested on a Ubuntu based distro but should be easily altered to run elsewhere.

    git-core
    bash
    tar
    gzip



##HOWTO c4-bootstrap


##HOWTO c4-repack

repack.sh is designed to help you manage servers that are already bootstraped. Once you have a bootstrapped server edit scripts/repack/00-suckfiles.sh and add more directories to the _working dirs()_ array. This will then allow the repack.sh script to copy these folders/files into the bootstrap files/ directory. On running repack.sh this will automatically copy your configured files into the system and commit them back to git.

