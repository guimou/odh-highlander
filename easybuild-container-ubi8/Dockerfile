FROM registry.access.redhat.com/ubi8/python-39:latest

# Install Dependencies
USER root

RUN yum -y update && \
    yum -y install iproute sudo nano lua binutils perl perl-libintl libtool diffutils \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/pam-1.3.1-15.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/pam-devel-1.3.1-15.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/ant-lib-1.10.5-1.module_el8.0.0+47+197dca37.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/ant-1.10.5-1.module_el8.0.0+47+197dca37.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/screen-4.6.2-12.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/lua-devel-5.3.4-11.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/lua-posix-33.3.1-9.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/lua-filesystem-1.6.3-7.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/http-parser-2.8.0-9.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/libibumad-32.0-4.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/infiniband-diags-32.0-4.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/librdmacm-32.0-4.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/ibacm-32.0-4.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/rdma-core-devel-32.0-4.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/perl-libintl-perl-1.29-2.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/perl-Text-Unidecode-1.30-5.el8.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/perl-Unicode-EastAsianWidth-1.33-13.el8.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/help2man-1.47.6-1.el8.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/texinfo-6.5-6.el8.x86_64.rpm \
    http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/sgml-common-0.6.3-50.el8.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/docbook-dtds-1.0-69.el8.noarch.rpm \
    http://mirror.centos.org/centos/8-stream/AppStream/x86_64/os/Packages/docbook-style-xsl-1.79.2-9.el8.noarch.rpm && \
    yum -y clean all && \
    rm -rf /var/cache/yum

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

RUN pip install wheel python-graph-core python-graph-dot && \
    chown -R easybuild:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P

ENV PATH="/opt/apps/easybuild/bin:${PATH}"
ENV MODULEPATH="/opt/apps/easybuild/modules:${MODULEPATH}"
ENV PYTHONPATH="/opt/apps/easybuild/lib/python3.9/site-packages:${PYTHONPATH}"
ENV XDG_CONFIG_DIRS="/opt/apps/easybuild"

USER easybuild

WORKDIR /opt/app-root/src

# Set the default CMD to print the usage of the language image.
CMD /opt/app-root/src/usage
