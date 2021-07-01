FROM quay.io/thoth-station/s2i-thoth-f32-py38:latest

# Install Dependencies
USER root

RUN adduser easybuild && echo "easybuild:easybuild" | chpasswd && usermod -aG wheel easybuild

RUN yum -y update && \
    yum -y install git tar which bzip2 xz \
            make automake gcc gcc-c++ patch \
            zlib-devel openssl-devel unzip iproute file \
            pam-devel ant sudo screen nano \
            lua lua-devel lua-posix lua-filesystem \
            tcl python-keyring http-parser rdma-core-devel && \
    yum -y clean all

# Build LMOD
ENV LMOD_VER 8.5.7

RUN mkdir -p /build
WORKDIR /build

RUN curl -LO http://github.com/TACC/Lmod/archive/${LMOD_VER}.tar.gz && \
    mv /build/${LMOD_VER}.tar.gz /build/Lmod-${LMOD_VER}.tar.gz && \
    tar xvf Lmod-${LMOD_VER}.tar.gz

WORKDIR /build/Lmod-${LMOD_VER}

RUN ./configure --prefix=/opt/apps --with-fastTCLInterp=no && \
    make install && \
    rm -rf /build && \
    ln -s /opt/apps/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh

USER 1001

COPY .bashenv /opt/apps/src/.bashenv

WORKDIR /opt/apps/src

ENV PATH="/opt/apps/easybuild/bin:${PATH}"
ENV PYTHONPATH="/opt/apps/easybuild/lib/python3.8/site-packages:${PYTHONPATH}"
ENV XDG_CONFIG_DIRS="/opt/apps/easybuild"
ENV BASH_ENV=/opt/apps/src/.bashenv

CMD /usr/bin/tail -f /dev/null