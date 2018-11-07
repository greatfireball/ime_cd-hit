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
