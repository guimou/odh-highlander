#!/bin/bash

# Install on first launch
if ! command -v easybuild &> /dev/null
then
    pip install --prefix /opt/apps/easybuild easybuild==4.4.1
    mkdir -p /opt/apps/easybuild/easybuild.d
    cp /opt/apps/src/config.cfg /opt/apps/easybuild/easybuild.d/config.cfg
fi
