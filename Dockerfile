FROM ubuntu
MAINTAINER bryce.hemme@gmail.com
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    libtool \
    pkg-config \
    autoconf \
    libssl-dev \
    check \
    libjansson-dev \
    sudo

RUN pip3 install requests pyjwt
RUN git clone https://github.com/benmcollins/libjwt &&\
    cd libjwt &&\
    git checkout tags/v1.8.0 &&\
    autoreconf -i &&\
    ./configure &&\
    make &&\
    make install
RUN apt-get install -y \
    apache2 \
    apache2-dev \
    libz-dev
RUN git clone https://github.com/AnthonyDeroche/mod_authnz_jwt &&\
    cd mod_authnz_jwt &&\
    autoreconf -ivf &&\
    ./configure &&\
    make &&\
    make install
RUN service apache2 restart
RUN cd mod_authnz_jwt/tests &&\
    cp debian_tests.sh debian_setup.sh &&\
    sed -i '$ d' debian_setup.sh &&\
    ./debian_setup.sh &&\
    chmod 644 /opt/mod_jwt_tests/rsa-priv.pem &&\
    chmod 644 /opt/mod_jwt_tests/ec-priv.pem &&\
    ./debian_tests.sh
