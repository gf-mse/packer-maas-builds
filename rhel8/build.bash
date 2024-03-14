#!/bin/bash

# ----------------------------
# settings

export PACKER_LOG=1
export PACKER_LOG_PATH="packer.build."`date +%F-t-%s`".log"

export KS_PROXY=''
export KS_APPSTREAM_REPOS='--baseurl="file:///run/install/repo/AppStream"'

export WORKDIR='./output-rhel8'
export KSFILE='rhel8.ks'

ISO_IMAGE='path/to/rhel8.iso'


# ----------------------------
# checks

# check that we have ISO_IMAGE variable properly set
if [ -f "${ISO_IMAGE}" ]; then : ; else
    echo "please edit '$0' and update ISO_IMAGE='${ISO_IMAGE}' line to set a correct RHEL 8 iso image path" >&2
    exit 10
fi

# do once
for F in *.new; do
    H=`basename $F .new`
    if [ -f "${H}.orig" ]; then : ; else
        mv "$H" "${H}.orig"
        cp -a "$F" "$H"
    fi
done


# ----------------------------
# build

rm -rf "${WORKDIR}"

## ( cd http && envsubst < "${KSFILE}.in" > "${KSFILE}" )
( cd http && envsubst < "${KSFILE}.pkrtpl.hcl" > "${KSFILE}" )

packer init .
packer build -var "rhel8_iso_path=${ISO_IMAGE}" .

