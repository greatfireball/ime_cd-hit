ARG osversion=xenial-20181005
FROM ubuntu:${osversion}

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

RUN echo "VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", VERSION: "${VERSION}

LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the cd-hit software package" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/ime_cd-hit.git"

RUN apt update && \
    apt install --yes \
	wget \
	build-essential && \
    apt autoclean && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

WORKDIR /opt

RUN wget -O - wget https://github.com/weizhongli/cdhit/releases/download/V4.6.8/cd-hit-v4.6.8-2017-1208-source.tar.gz | \
    tar xzf - && \
    ln -s cd-hit-v4.6.8-2017-1208 cd-hit && \
    cd cd-hit && \
    make && \
    cd cd-hit-auxtools/ && \
    make

ENV PATH=/opt/cd-hit/:${PATH}
