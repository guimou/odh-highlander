#!/bin/sh
# Info on running container
CONTAINER_NAME=`cat /etc/hostname`

cat <<EOF
Easybuild container is running with id ${CONTAINER_NAME}.

Locally, you can connect to it with:
docker exec -it -u easybuild ${CONTAINER_NAME} bash -l
or
podman exec -it -u easybuild ${CONTAINER_NAME} bash -l

On Kubernetes or OpenShift, you can connect with:
kubectl exec -it ${CONTAINER_NAME} -- bash -l
or 
oc exec -it ${CONTAINER_NAME} -- bash -l

Locally, you can end this container it by running:
docker kill ${CONTAINER_NAME}
or press CTRL+C
EOF

# Always run hack
/usr/bin/tail -f /dev/null
