#!/bin/sh
./vm-image.sh \
-b https://download.fedoraproject.org/pub/fedora/linux/releases/33/Cloud/x86_64/images/Fedora-Cloud-Base-33-1.2.x86_64.qcow2 \
-r quay.io/guimou/easybuild-vm \
-t fc33-1.2
