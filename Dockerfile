ARG FROM_IMAGE
ARG FROM_TAG

FROM $FROM_IMAGE:$FROM_TAG

ARG OS_VERSION
ARG PYGIT2_VERSION
ARG IMAGE_AUTHOR
ARG ARCH
ARG SALTSTACK_VERSION
ENV OS_VERSION "${OS_VERSION}"
ENV PYGIT2_VERSION "${PYGIT2_VERSION}"
ENV IMAGE_AUTHOR "${IMAGE_AUTHOR}"
ENV ARCH "${ARCH}"
ENV SALTSTACK_VERSION "${SALTSTACK_VERSION}"
ENV GPG_PUBKEY_URL "https://repo.saltproject.io/salt/py3/redhat/${OS_VERSION}/${ARCH}/SALT-PROJECT-GPG-PUBKEY-2023.pub"

LABEL org.opencontainers.image.authors="${IMAGE_AUTHOR}"

RUN rpm --import "${GPG_PUBKEY_URL}"

ADD https://repo.saltproject.io/salt/py3/redhat/9/x86_64/minor/${SALTSTACK_VERSION}.repo /etc/yum.repos.d/salt.repo

RUN microdnf install epel-release
RUN microdnf install -y openssh-clients salt-ssh binutils patchelf

RUN salt-pip install pygit2==${PYGIT2_VERSION}

WORKDIR /salt

ENTRYPOINT [ "salt-ssh" ]

CMD [ "" ]