#!/bin/bash

export PACKER_LOG=1
export PACKER_LOG_PATH="packer.build."`date +%F-t-%s`".log"

export KS_PROXY=''

export WORKDIR='./output-rocky8'
export KSFILE='rocky.ks'

# do once
for F in *.new; do
    H=`basename $F .new`
    if [ -f "${H}.orig" ]; then : ; else
        mv "$H" "${H}.orig"
        cp -a "$F" "$H"
    fi
done

rm -rf "${WORKDIR}"

( cd http && envsubst < "${KSFILE}.in" > "${KSFILE}" )

packer init .
packer build .



