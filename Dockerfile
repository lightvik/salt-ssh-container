ARG OS_VERSION

FROM oraclelinux:${OS_VERSION:-9}-slim

ARG IMAGE_AUTHOR='lightvik@yandex.ru'
ARG ARCH='x86_64'
ARG OS_VERSION='9'
ARG SALTSTACK_VERSION='3007.0'
ARG GPG_PUBKEY_URL='https://repo.saltproject.io/salt/py3/redhat/${OS_VERSION}/${ARCH}/SALT-PROJECT-GPG-PUBKEY-2023.pub'

LABEL org.opencontainers.image.authors="${IMAGE_AUTHOR}"

RUN rpm --import https://repo.saltproject.io/salt/py3/redhat/${OS_VERSION}/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub

ADD https://repo.saltproject.io/salt/py3/redhat/9/x86_64/minor/${SALTSTACK_VERSION}.repo /etc/yum.repos.d/salt.repo

RUN microdnf install -y openssh-clients salt-ssh

WORKDIR /salt
