#!/bin/sh
./vm-easybuild-image.sh \
-b https://download.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.qcow2 \
-r quay.io/guimou/easybuild-vm \
-t fc32-1.6
