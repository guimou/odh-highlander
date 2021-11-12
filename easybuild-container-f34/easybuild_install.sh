#!/bin/bash

# Install on first launch
if ! command -v easybuild &> /dev/null
then
    # Install EasyBuild
    pip install --prefix /opt/apps/easybuild easybuild==4.4.2
    # Create configuration file
    mkdir -p /opt/apps/easybuild/easybuild.d
    cp /opt/app-root/src/config.cfg /opt/apps/easybuild/easybuild.d/config.cfg
    # Create the "featured" category to filter packages
    mkdir -p /opt/apps/easybuild/modules/featured
fi
