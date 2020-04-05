FROM centos:7

ENV PATH=/root/tools/optimise-images:$PATH
WORKDIR /root/tools/optimise-images
COPY . .

RUN set -x \
    && yum -y update \
    && bash -x ./optimise-images.sh \
    && yum clean all
