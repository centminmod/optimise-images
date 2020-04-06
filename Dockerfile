FROM centos:7

ENV PATH=/root/tools/optimise-images:$PATH
WORKDIR /root/tools/optimise-images
COPY . .

RUN set -x \
    && yum -y update \
    && bash -x ./optimise-images.sh \
    && bash -x ./optimise-images.sh install-mozjpeg \
    && rm -rf /root/tools/optimise-images/images/* \
    && yum clean all
