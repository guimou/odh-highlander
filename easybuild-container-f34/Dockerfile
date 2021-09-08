FROM quay.io/thoth-station/s2i-thoth-f34-py39:v0.31.1

# Install Dependencies
USER root

RUN yum -y update && \
    yum -y install git tar which bzip2 xz \
            make automake autoconf libtool gcc gcc-c++ patch \
            zlib-devel openssl-devel unzip iproute file \
            pam-devel ant sudo screen nano \
            lua lua-devel lua-posix lua-filesystem \
            tcl python-keyring http-parser rdma-core-devel \
            help2man flex ncurses cmake rust perl && \
    rm -rf /var/cache/yum && \
    pip install wheel python-graph-core python-graph-dot

# Build LMOD
ENV LMOD_VER 8.5.13

RUN mkdir -p /build/Lmod-${LMOD_VER}

WORKDIR /build/Lmod-${LMOD_VER}

RUN curl -L http://github.com/TACC/Lmod/archive/${LMOD_VER}.tar.gz -o /build/Lmod-${LMOD_VER}.tar.gz && \
    tar xvf /build/Lmod-${LMOD_VER}.tar.gz -C /build && \
    ./configure --prefix=/opt/apps --with-fastTCLInterp=no && \
    make install && \
    rm -rf /build && \
    ln -s /opt/apps/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh

# Add easybuild user and let it run the show
RUN adduser easybuild && \
    echo "easybuild:easybuild" | chpasswd && usermod -aG wheel easybuild && \
    echo "easybuild ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/easybuild

COPY . /opt/app-root/src/

COPY .bash_profile /opt/app-root/src/.bash_profile

RUN chown -R easybuild:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P

ENV PATH="/opt/apps/easybuild/bin:${PATH}"
ENV MODULEPATH="/opt/apps/easybuild/modules:${MODULEPATH}"
ENV PYTHONPATH="/opt/apps/easybuild/lib/python3.9/site-packages:${PYTHONPATH}"
ENV XDG_CONFIG_DIRS="/opt/apps/easybuild"

USER easybuild

WORKDIR /opt/app-root/src

# Set the default CMD to print the usage of the language image.
CMD /opt/app-root/src/usage
