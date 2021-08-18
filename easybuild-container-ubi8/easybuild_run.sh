#!/bin/sh
# Info on running container
CONTAINER_NAME=`cat /etc/hostname`

cat <<EOF
Easybuild container is running with id ${CONTAINER_NAME}.

You can connect to it locally by running:
docker exec -it -u easybuild ${CONTAINER_NAME} bash -l

You can kill it by running:
docker kill ${CONTAINER_NAME}
EOF

# Always run hack
/usr/bin/tail -f /dev/null
