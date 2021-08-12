FROM registry.access.redhat.com/ubi8/s2i-core:1

USER 1001

COPY --chown=1001:0 easybuild-data/. /opt/app-root/src/easybuild-data/

COPY copy_data.sh /opt/app-root/src/copy_data.sh
