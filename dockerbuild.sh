#!/bin/bash
##############################
# docker build script
##############################
TAG_VERSION='1.0'

db() {
  if [[ -f /usr/bin/docker && -f Dockerfile ]]; then
    echo "build Dockerfile"
    if [[ "$(docker images -f "reference=optimise-images:${TAG_VERSION}" >/dev/null 2>&1; echo $?)" -eq '0' ]]; then
      docker rmi optimise-images:${TAG_VERSION}
    fi
    docker build --tag optimise-images:${TAG_VERSION} .
    echo
    echo "built docker image"
    docker images -f "reference=optimise-images:${TAG_VERSION}"
    echo
    echo "check docker image built software"
    echo
    echo "docker run --rm -it optimise-images:${TAG_VERSION} /opt/mozjpeg/bin/jpegtran -version"
    docker run --rm -it optimise-images:${TAG_VERSION} /opt/mozjpeg/bin/jpegtran -version
    echo
    echo "docker run --rm -it optimise-images:${TAG_VERSION} /usr/bin/butteraugli"
    docker run --rm -it optimise-images:${TAG_VERSION} /usr/bin/butteraugli
    echo
    echo "docker run --rm -it optimise-images:${TAG_VERSION} optimise-images.sh"
    docker run --rm -it optimise-images:${TAG_VERSION} optimise-images.sh
    echo
    echo "docker image build completed"
  else
    echo "docker not installed"
    exit
  fi
}

testrun() {
  echo "test optimise-images.sh docker image"
  echo
  echo "optimise-images.sh bench-webpcompare"
  echo
  echo "docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:${TAG_VERSION} optimise-images.sh bench-webpcompare"
  docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:${TAG_VERSION} optimise-images.sh bench-webpcompare
}

case "$1" in
  build )
    db
    ;;
  test )
    testrun
    ;;
  * )
    echo "$0 {build|test}"
    ;;
esac