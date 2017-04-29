#! /bin/bash
########################################################################
# batch optimise images
# written by George Liu (eva2000) centminmod.com
# docs
# https://www.imagemagick.org/Usage/thumbnails/
# https://www.imagemagick.org/Usage/files/#read_mods
# https://www.imagemagick.org/Usage/advanced/
# https://www.imagemagick.org/Usage/basics/#mogrify
# https://www.imagemagick.org/script/command-line-options.php#define
# https://www.imagemagick.org/Usage/files/#write
# https://www.imagemagick.org/Usage/api/#scripts
# https://www.imagemagick.org/Usage/files/#massive
# https://www.imagemagick.org/script/architecture.php
#
# webp
# http://caniuse.com/#feat=webp
# https://developers.google.com/speed/webp/
# https://www.imagemagick.org/script/webp.php
#
# guetzli
# https://github.com/google/guetzli/
# https://github.com/google/guetzli/issues/195
#
# mozjpeg
# https://github.com/mozilla/mozjpeg
#
# test images
# https://testimages.org/
# https://css-ig.net/png-test-corpus
# https://github.com/nwtn/image-resize-tests/blob/master/asset-sources.txt
# https://github.com/FLIF-hub/benchmarks
#
# butteraugli
# https://github.com/google/butteraugli
#
# GraphicsMagick
# http://www.graphicsmagick.org/convert.html
# http://www.graphicsmagick.org/identify.html
########################################################################
DT=$(date +"%d%m%y-%H%M%S")
VER='2.9'
DEBUG='y'

# control sample image downloads
# allows you to control how many sample images to work with/download
# guetzli testing is very resource and time consuming so working with
# a smaller sample image set would be better
TESTFILES_MINIMAL='y'
TESTFILES_PNGONLY='n'
TESTFILES_JPEGONLY='n'

# max width and height
MAXRES='2048'

# ImageMagick Settings
IMAGICK_RESIZE='y'
IMAGICK_JPEGHINT='y'
IMAGICK_QUALITY='82'
IMAGICK_WEBP='n'
IMAGICK_WEBPQUALITY='75'
IMAGICK_WEBPQUALITYALPHA='100'
IMAGICK_WEBPMETHOD='4'
IMAGICK_WEBPLOSSLESS='n'
IMAGICK_WEBPTHREADS='1'
# Quantum depth 8 or 16 for ImageMagick 7
# Source installs
IMAGICK_QUANTUMDEPTH='8'
IMAGICK_SEVEN='n'
IMAGICK_TMPDIR='/home/imagicktmp'
IMAGICK_JPGOPTS=' -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045'
IMAGICK_PNGOPTS=' -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2'
IMAGICK_WEBPOPTS=" -define webp:method=${IMAGICK_WEBPMETHOD} -define webp:alpha-quality=${IMAGICK_WEBPQUALITYALPHA} -define webp:lossless=false -quality ${IMAGICK_WEBPQUALITY}"

# GraphicsMagick Settings
GM_USE='n'

# strip meta-data
STRIP='y'

# additional image optimisations after imagemagick
# resizing
# choose one of the 3 JPEGOPTIM, GUETZLI or MOZJPEG
JPEGOPTIM='y'
GUETZLI='n'
MOZJPEG='n'
# choose either OPTIPNG or ZOPFLIPNG
OPTIPNG='y'
ZOPFLIPNG='n'

# Speed control
# default is -o2 set 2
OPTIPNG_COMPRESSION='2'

# Guetzli Options
# GUETZLI_JPEGONLY will only optimise original jpeg/jpg
# images and NOT convert png to Guetzli optimised jpgs
# set to = 'n' to convert png as well
GUETZLI_JPEGONLY='y'
GUETZLI_QUALITY='85'
GUETZLI_OPTS='--verbose'

# MozJPEG Options
# MOZJPEG_JPEGONLY will only optimise original jpeg/jpg
# images and NOT convert png to MozJPEG optimised jpgs
# set to = 'n' to convert png as well
MOZJPEG_JPEGONLY='y'
MOZJPEG_JPEGTRAN='y'
MOZJPEG_CJPEG='n'
MOZJPEG_QUALITY='-quality 82'
MOZJPEG_OPTS='-verbose'

# ZopfliPNG Settings
# Always create ZopfliPNG version even if original is
# smaller for benchmarking. 
ZOPFLIPNG_ALWAYS='y'
# Default iterations is 15 for small files 
# 5 for large files. Set to Auto for defaults
ZOPFLIPNG_ITERATIONS='auto'
# --lossy_8bit --lossy_transparent
ZOPFLIPNG_LOSSY='n'

# profile option display fields for transparency color and background color
# disabled by default to speed up profile processing
PROFILE_EXTEND='n'

# comparison mode when enabled will when resizing and optimising images
# write to a separate optimised image within the same directory as the
# original images but with a suffix attached to the end of original image
# file name i.e. image.png vs image_optimal.png
COMPARE_MODE='n'
COMPARE_SUFFIX='_optimal'

# optionally create thumbnails in separate directory
# within image directory and thumbnail width x height
# and thumbnail image format default = .jpg
THUMBNAILS='n'
THUMBNAILS_QUALITY='70'
THUMBNAILS_WIDTH='160'
THUMBNAILS_HEIGHT='160'
THUMBNAILS_FORMAT='jpg'
THUMBNAILS_DIRNAME='thumbnails'

LOGDIR='/home/optimise-logs'
LOGNAME_PROFILE="profile-log-${DT}.log"
LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
BENCHDIR='/home/optimise-benchmarks'

GUETZLI_BIN='/opt/guetzli/bin/Release/guetzli'
BUTTERAUGLI_BIN='/usr/bin/butteraugli'
GM_BIN='/usr/bin/gm'
########################################################################
# DO NOT EDIT BELOW THIS POINT

if [ ! -f /etc/yum.repos.d/epel.repo ]; then
  yum -q -y install epel-release
fi

if [[ "$MOZJPEG_JPEGTRAN" = [yY] ]]; then
  MOZJPEG_BIN='/opt/mozjpeg/bin/jpegtran'
  MOZJPEG_QUALITY=""
else
  MOZJPEG_BIN='/opt/mozjpeg/bin/cjpeg'
fi

# Binary paths
if [[ "$GM_USE" = [yY] && -f /usr/bin/gm ]]; then
  IDENTIFY_BIN='/usr/bin/gm identify'
  CONVERT_BIN='/usr/bin/gm convert'
elif [[ "$IMAGICK_SEVEN" = [yY] && -f /opt/imagemagick7/bin/identify ]]; then
  IDENTIFY_BIN='/opt/imagemagick7/bin/identify'
  CONVERT_BIN='/opt/imagemagick7/bin/convert'
else
  IDENTIFY_BIN='/usr/bin/identify'
  CONVERT_BIN='/usr/bin/convert'
fi

if [ -f /proc/user_beancounters ]; then
    CPUS=$(cat "/proc/cpuinfo" | grep "processor"|wc -l)
else
    # speed up make
    CPUS=$(cat "/proc/cpuinfo" | grep "processor"|wc -l)
fi

if [[ "$CPUS" -ge ' 4' ]]; then
  IMAGICK_THREADLIMIT=$(($CPUS/2))
  export MAGICK_THREAD_LIMIT="$IMAGICK_THREADLIMIT"
  IMAGICK_WEBPTHREADSOPTS=" -define webp:thread-level=${IMAGICK_WEBPTHREADS}"
else
  IMAGICK_WEBPTHREADSOPTS=""
fi

if [ ! -f /usr/bin/sar ]; then
  yum -y -q install sysstat
  if [[ "$(uname -m)" = 'x86_64' ]]; then
    SARCALL='/usr/lib64/sa/sa1'
  else
    SARCALL='/usr/lib/sa/sa1'
  fi
else
  if [[ "$(uname -m)" = 'x86_64' ]]; then
    SARCALL='/usr/lib64/sa/sa1'
  else
    SARCALL='/usr/lib/sa/sa1'
  fi
fi

if [ ! -f /usr/bin/bc ]; then
  yum -q -y install bc
fi

if [ ! -f /usr/bin/optipng ]; then
  yum -q -y install optipng
fi

if [ ! -f /usr/bin/jpegoptim ]; then
  yum -q -y install jpegoptim
fi

if [ ! -f /usr/bin/gm ]; then
  yum -q -y install GraphicsMagick
fi

if [[ "$ZOPFLIPNG" = [yY] && ! -f /usr/bin/zopflipng ]]; then
  echo "installing zopflipng"
  mkdir -p /opt/zopfli
  cd /opt/zopfli
  git clone https://github.com/google/zopfli
  cd zopfli/
  make -s -j2
  make -s zopflipng
  make -s libzopfli
  \cp -f zopflipng /usr/bin/zopflipng
  # OPTIPNG='n'
  echo "installed zopflipng"
elif [[ "$ZOPFLIPNG" = [yY] && -f /usr/bin/zopflipng ]]; then
  # OPTIPNG='n'
  echo
fi

if [[ "$STRIP" = [Yy] ]]; then
  STRIP_OPT=' -strip'
else
  STRIP_OPT=""
fi

if [[ "$IMAGICK_JPEGHINT" = [yY] ]]; then
  JPEGHINT_WIDTH=$(($MAXRES*2))
  JPEGHINT_HEIGHT=$(($MAXRES*2))
  JPEGHINT_OPT=" -define jpeg:size=${JPEGHINT_WIDTH}x${JPEGHINT_HEIGHT}"
else
  JPEGHINT_OPT=""
fi

if [[ "$IMAGICK_WEBP" = [yY] ]]; then
  FIND_WEBP=' -o -name "*.webp"'
else
  FIND_WEBP=""
fi

if [[ "$IMAGICK_WEBPLOSSLESS" = [yY] ]]; then
  IMAGICK_WEBPOPTS=" -define webp:method=${IMAGICK_WEBPMETHOD} -define webp:lossless=true"
fi

if [[ "$ZOPFLIPNG_ALWAYS" = [yY] ]]; then
  ZOPFLIPNG_OPTSALWAYS=' --always_zopflify'
else
  ZOPFLIPNG_OPTSALWAYS=''
fi

if [[ "$ZOPFLIPNG_LOSSY" = [yY] ]]; then
  ZOPFLIPNG_OPTSLOSSY=' --lossy_8bit --lossy_transparent'
else
  ZOPFLIPNG_OPTSLOSSY=''
fi

if [[ "$ZOPFLIPNG_ITERATIONS" = 'auto' ]]; then
  # other options
  # --filters=01234mepb
  ZOPFLIPNG_OPTS=" -y${ZOPFLIPNG_OPTSALWAYS}${ZOPFLIPNG_OPTSLOSSY}"
else
  ZOPFLIPNG_OPTS=" -y --iterations=${ZOPFLIPNG_ITERATIONS}${ZOPFLIPNG_OPTSALWAYS}${ZOPFLIPNG_OPTSLOSSY}"
fi

if [ ! -d "$IMAGICK_TMPDIR" ]; then
  mkdir -p "$IMAGICK_TMPDIR"
  chmod 1777 "$IMAGICK_TMPDIR"
elif [ -d "$IMAGICK_TMPDIR" ]; then
  chmod 1777 "$IMAGICK_TMPDIR"
fi

if [ ! -d  "$LOGDIR" ]; then
  mkdir -p "$LOGDIR"
fi

if [ ! -d  "$BENCHDIR" ]; then
  mkdir -p "$BENCHDIR"
fi

IMAGICK_VERSION=$($CONVERT_BIN -version | head -n1 | awk '/^Version:/ {print $2,$3,$4,$5,$6}')
##########################################################################
# function

if [[ "$GM_USE" = [yY] ]]; then
  IMAGICK_TMPDIR='/home/imagicktmp'
  IMAGICK_JPGOPTS=' -filter triangle -unsharp 0.25x0.08+8.3+0.045'
  IMAGICK_PNGOPTS=''
  IMAGICK_WEBPOPTS=" -quality ${IMAGICK_WEBPQUALITY}"
  JPEGHINT_WIDTH=$(($MAXRES*2))
  JPEGHINT_HEIGHT=$(($MAXRES*2))
  JPEGHINT_OPT=" -size ${JPEGHINT_WIDTH}x${JPEGHINT_HEIGHT}"
  DEFINE_TMP=''
else
  DEFINE_TMP=" -define registry:temporary-path="${IMAGICK_TMPDIR}""
fi

mozjpeg_install() {
  if [ ! -f /usr/bin/nasm ]; then
    yum -q -y install nasm
  fi
  echo "installing mozjpeg"
  cd /usr/src
  wget https://github.com/mozilla/mozjpeg/releases/download/v3.2-pre/mozjpeg-3.2-release-source.tar.gz
  cd mozjpeg
  ./configure
  make -s
  make -s install
  MOZJPEG_BIN='/opt/mozjpeg/bin/jpegtran'
  echo "installed mozjpeg" 
}

butteraugli_install() {
  echo "installing butteraugli"
  cd /opt
  rm -rf butteraugli
  git clone https://github.com/google/butteraugli
  cd butteraugli/butteraugli
  make
  \cp -af butteraugli /usr/bin/butteraugli
  BUTTERAUGLI_BIN='/usr/bin/butteraugli'
  echo "installed butteraugli" 
}

guetzli_install() {
  echo "installing guetzli"
  cd /opt
  rm -rf guetzli
  git clone https://github.com/google/guetzli
  cd guetzli
  make
  GUETZLI_BIN='/opt/guetzli/bin/Release/guetzli'
  echo "installed guetzli"
}

if [[ "$GUETZLI" = [yY] && ! -f /usr/bin/libpng-config && ! -f "$GUETZLI_BIN" ]]; then
  yum -q -y install libpng-devel
  guetzli_install
elif [[ "$GUETZLI" = [yY] && -f /usr/bin/libpng-config && ! -f "$GUETZLI_BIN" ]]; then
  guetzli_install
fi

if [[ ! -f "$BUTTERAUGLI_BIN" ]]; then
  butteraugli_install
fi

install_source() {
  echo "------------------------------------"
  echo "install ImageMagick 7 at:"
  echo "/opt/imagemagick7/bin/identify"
  echo "/opt/imagemagick7/bin/convert"
  echo "------------------------------------"
  CPUVENDOR=$(cat /proc/cpuinfo | awk '/vendor_id/ {print $3}' | sort -u | head -n1)
  SSECHECK=$(gcc -c -Q -march=native --help=target | awk '/  -msse/ {print $2}' | head -n1)

  if [[ "$(uname -m)" = 'x86_64' && "$CPUVENDOR" = 'GenuineIntel' && "$SSECHECK" = '[enabled]' ]]; then
      CCM=64
      CRYPTOGCC_OPT="-m${CCM} -march=native"
      # if only 1 cpu thread use -O2 to keep compile times sane
      if [[ "$CPUS" = '1' ]]; then
      export CFLAGS="-O2 $CRYPTOGCC_OPT -pipe"
      else
      export CFLAGS="-O3 $CRYPTOGCC_OPT -pipe"
      fi
      export CXXFLAGS="$CFLAGS"
  fi

  # built Q8 instead system Q16 for speed
  # http://www.imagemagick.org/script/advanced-unix-installation.php
  cd /usr/src
  rm -rf ImageMagick.tar.gz
  rm -rf ImageMagick-7*
  wget -cnv https://www.imagemagick.org/download/ImageMagick.tar.gz
  tar xzf ImageMagick.tar.gz
  cd ImageMagick-7*
  make clean
  ./configure CFLAGS="$CFLAGS" --prefix=/opt/imagemagick7 --with-quantum-depth="${IMAGICK_QUANTUMDEPTH}"
  make -j${CPUS}
  make install
  IDENTIFY_BIN='/opt/imagemagick7/bin/identify'
  CONVERT_BIN='/opt/imagemagick7/bin/convert'
  echo "------------------------------------"
  echo ""
  echo "------------------------------------"
}

sar_call() {
  $SARCALL 1 1
}

testfiles() {
  WORKDIR=$1
  echo "Downloading sample image files"
  echo "to $WORKDIR"
  cd "$WORKDIR"
  if [[ "$TESTFILES_PNGONLY" != [yY] ]]; then
    wget -cnv -O samsung_s7_mobile_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/samsung_s7_mobile_1.jpg
    wget -cnv -O dslr_canon_eos_m6_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_m6_1.jpg
    wget -cnv -O dslr_nikon_d7200_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d7200_1.jpg
    wget -cnv -O dslr_nikon_d7200_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d7200_2.jpg
  fi
  if [[ "$TESTFILES_JPEGONLY" != [yY] ]]; then
    wget -cnv -O bees.png https://github.com/centminmod/optimise-images/raw/master/images/bees.png
    wget -cnv -O webp-study-source-firebreathing.png https://github.com/centminmod/optimise-images/raw/master/images/webp-study-source-firebreathing.png
    wget -cnv -O png24-image1.png https://github.com/centminmod/optimise-images/raw/master/images/png24-image1.png
    wget -cnv -O png24-interlaced-image1.png https://github.com/centminmod/optimise-images/raw/master/images/png24-interlaced-image1.png
  fi
  if [[ "$TESTFILES_MINIMAL" != [yY] ]]; then
    if [[ "$TESTFILES_PNGONLY" != [yY] ]]; then
      wget -cnv -O IceAlpha.png https://github.com/centminmod/optimise-images/raw/master/images/IceAlpha.png
      wget -cnv -O MagnoliaAlpha.png https://github.com/centminmod/optimise-images/raw/master/images/MagnoliaAlpha.png
      wget -cnv -O OwlAlpha.png https://github.com/centminmod/optimise-images/raw/master/images/OwlAlpha.png
      wget -cnv -O RedbrushAlpha.png https://github.com/centminmod/optimise-images/raw/master/images/RedbrushAlpha.png
      wget -cnv -O pnglogo-blk.png https://github.com/centminmod/optimise-images/raw/master/images/pnglogo-blk.png
      wget -cnv -O 001.png https://github.com/centminmod/optimise-images/raw/master/images/001.png
      wget -cnv -O 002.png https://github.com/centminmod/optimise-images/raw/master/images/002.png
      wget -cnv -O 003.png https://github.com/centminmod/optimise-images/raw/master/images/003.png
      wget -cnv -O 004.png https://github.com/centminmod/optimise-images/raw/master/images/004.png
      wget -cnv -O 005.png https://github.com/centminmod/optimise-images/raw/master/images/005.png
      wget -cnv -O trucking_16AA.png https://github.com/centminmod/optimise-images/raw/master/images/trucking_16AA.png
      wget -cnv -O trucking_196AA.png https://github.com/centminmod/optimise-images/raw/master/images/trucking_196AA.png
      wget -cnv -O trucking_400AA.png https://github.com/centminmod/optimise-images/raw/master/images/trucking_400AA.png
      wget -cnv -O dslr_sony_alpha_a99_ii_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_sony_alpha_a99_ii_1.jpg
      wget -cnv -O dslr_sony_alpha_a99_ii_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_sony_alpha_a99_ii_2.jpg
      wget -cnv -O mobile1.jpg https://github.com/centminmod/optimise-images/raw/master/images/mobile1.jpg
      wget -cnv -O mobile2.jpg https://github.com/centminmod/optimise-images/raw/master/images/mobile2.jpg
      wget -cnv -O mobile3.jpg https://github.com/centminmod/optimise-images/raw/master/images/mobile3.jpg
      wget -cnv -O image1.jpg https://github.com/centminmod/optimise-images/raw/master/images/image1.jpg
      wget -cnv -O image2.jpg https://github.com/centminmod/optimise-images/raw/master/images/image2.jpg
      wget -cnv -O image3.jpg https://github.com/centminmod/optimise-images/raw/master/images/image3.jpg
      wget -cnv -O image4.jpg https://github.com/centminmod/optimise-images/raw/master/images/image4.jpg
      wget -cnv -O image6.jpg https://github.com/centminmod/optimise-images/raw/master/images/image6.jpg
      wget -cnv -O image7.jpg https://github.com/centminmod/optimise-images/raw/master/images/image7.jpg
      wget -cnv -O image7.jpg https://github.com/centminmod/optimise-images/raw/master/images/image7.jpg
      wget -cnv -O dslr_canon_eos_m6_large1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_m6_large1.jpg
      wget -cnv -O dslr_canon_eos_m6_large2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_m6_large2.jpg
      wget -cnv -O dslr_canon_eos_77d_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_77d_1.jpg
      wget -cnv -O dslr_canon_eos_77d_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_77d_2.jpg
      wget -cnv -O dslr_hasselblad_x1d_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_hasselblad_x1d_1.jpg
      wget -cnv -O dslr_hasselblad_x1d_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_hasselblad_x1d_2.jpg
      wget -cnv -O dslr_leica_m10_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_leica_m10_1.jpg
      wget -cnv -O dslr_leica_m10_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_leica_m10_2.jpg
      wget -cnv -O dslr_nikon_d5_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d5_1.jpg
      wget -cnv -O dslr_nikon_d5_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d5_2.jpg
      cp image4.jpg "im age5.jpg"
    fi
    if [[ "$TESTFILES_JPEGONLY" != [yY] ]]; then
      wget -cnv -O webp-study-source-google-chart-tools.png https://github.com/centminmod/optimise-images/raw/master/images/webp-study-source-google-chart-tools.png
      wget -cnv -O pngimage1.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage1.png
      wget -cnv -O pngimage2.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage2.png
      wget -cnv -O pngimage3.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage3.png
      wget -cnv -O pngimage4.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage4.png
      wget -cnv -O screenshot1.png https://github.com/centminmod/optimise-images/raw/master/images/screenshot1.png
      wget -cnv -O lenna.png https://github.com/centminmod/optimise-images/raw/master/images/lenna.png
    fi
  fi
  echo
  ls -lah "$WORKDIR"
}

profiler() {
  starttime=$(TZ=UTC date +%s.%N)
  {
  WORKDIR=$1
  LOGONLY=$2
  if [[ "$LOGONLY" != 'logonly' ]]; then
    echo
    echo "------------------------------------------------------------------------------"
    echo "image profile"
    if [[ "$PROFILE_EXTEND" = [yY] ]]; then
      echo "image name : width : height : quality : transparency : image depth (bits) : size : user: group : transparency color : background color : interlaced"
    else
      echo "image name : width : height : quality : transparency : image depth (bits) : size : user: group"
    fi
    echo "------------------------------------------------------------------------------"
    echo "images in $WORKDIR"
    echo "logged at $LOG_PROFILE"
    echo "------------------------------------------------------------------------------"
  fi
  cd "$WORKDIR"
  {
  if [[ "$LOGONLY" = 'logonly' ]]; then
    echo "directory : $WORKDIR"
  fi
  if [[ "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" | sort | while read i; do
    file=$(basename "${i}")
    extension="${file##*.}"
    filename="${file%.*}"
    echo -n "image : "$file" : ";
    if [[ "$GM_USE" = [yY] ]]; then
      echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %q :' "$file") ";
    else
      echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %z :' "$file") ";
    fi
    if [[ "$PROFILE_EXTEND" = [yY] ]]; then
      echo -n "$(stat -c "%s : %U : %G" "$file") : ";
      if [[ "$GM_USE" = [yY] ]]; then
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
        echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Background Color: / {print $3}')";
      else
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
        echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Background color: / {print $3}')";
      fi
    else
      echo "$(stat -c "%s : %U : %G" "$file")";
    fi
    done
  else
    find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do
    file=$(basename "${i}")
    extension="${file##*.}"
    filename="${file%.*}"
    echo -n "image : "$file" : ";
    if [[ "$GM_USE" = [yY] ]]; then
      echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %q :' "$file") ";
    else
      echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %z :' "$file") ";
    fi
    if [[ "$PROFILE_EXTEND" = [yY] ]]; then
      echo -n "$(stat -c "%s : %U : %G" "$file") : ";
      if [[ "$GM_USE" = [yY] ]]; then
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Background Color: / {print $3}') : ";
        echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Interlace/ {print $2}')"
      else
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
        echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Background color: / {print $3}') : ";
        echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Interlace/ {print $2}')"
      fi
    else
      echo "$(stat -c "%s : %U : %G" "$file")";
    fi
    done
  fi
  } 2>&1 | tee "$LOG_PROFILE"
  if [[ "$LOGONLY" = 'logonly' ]]; then
    echo
    echo "logged at $LOG_PROFILE"
    echo
  fi
  if [[ "$LOGONLY" != 'logonly' ]]; then
    echo
    echo "------------------------------------------------------------------------------"
    echo "Original or Existing Images:"
    echo "------------------------------------------------------------------------------"
    printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
    printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
    # optimise routine so no need to do a find - sort - while loop again instead rely on the
    # tee $LOG_PROFILE log created earlier to get image statistics and information
    if [[ "$COMPARE_MODE" = [yY] && "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR,   c4/NR, c5/NR, c8/NR, tb, tk/1024}'
    elif [[ "$COMPARE_MODE" = [nN] && "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR,   c4/NR, c5/NR, c8/NR, tb, tk/1024}'
    elif [[ "$COMPARE_MODE" = [nN] && "$IMAGICK_WEBP" = [nN] ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR,   c4/NR, c5/NR, c8/NR, tb, tk/1024}'
    else
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR,   c4/NR, c5/NR, c8/NR, tb, tk/1024}'
    fi

    if [[ "$OPTIPNG" = [yY] && "$ZOPFLIPNG" = [yY] && "$(ls "$WORKDIR" | grep '.zopflipng.png')" && "$(ls "$WORKDIR" | grep '.optipng.png')" ]]; then
      if [[ "$(ls "$WORKDIR" | grep '.optipng.png')" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised PNG Images (optipng):"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
        if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | grep '.optipng.png :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        else
        cat "$LOG_PROFILE" | grep '.optipng.png :' | grep -v "${COMPARE_SUFFIX}.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        fi
      fi
      if [[ "$(ls "$WORKDIR" | grep '.zopflipng.png')" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised PNG Images (zopflipng):"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
        if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | grep '.zopflipng.png :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        else
        cat "$LOG_PROFILE" | grep '.zopflipng.png :' | grep -v "${COMPARE_SUFFIX}.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        fi
      fi
    fi
  
    if [[ "$COMPARE_MODE" = [yY] ]]; then
      if [[ "$(ls "$WORKDIR" | grep "$COMPARE_SUFFIX")" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised Images:"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
      cat "$LOG_PROFILE" | egrep "${COMPARE_SUFFIX}.jpg :|${COMPARE_SUFFIX}.png :|${COMPARE_SUFFIX}.jpeg :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
      fi
    fi
  
    if [[ "$IMAGICK_WEBP" = [yY] ]]; then
      if [[ "$(ls "$WORKDIR" | grep '.webp')" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised WebP Images:"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
        if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | grep '.webp :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        else
        cat "$LOG_PROFILE" | grep '.webp :' | grep -v "${COMPARE_SUFFIX}.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        fi
      fi
    fi

    if [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] && "$MOZJPEG_JPEGONLY" = [yY] ]]; then
      if [[ "$(ls "$WORKDIR" | grep '.mozjpeg.jpg')" ]] && [[ ! "$(ls "$WORKDIR" | grep '.guetzli.jpg')" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised Jpg Images (jpegoptim):"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
        if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | egrep -v ".webp :|.mozjpeg.jpg :|.guetzli.jpg :|.png :" | grep "$COMPARE_SUFFIX" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        else
        cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.mozjpeg.jpg :|.guetzli.jpg :|.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        fi

        if [[ "$(ls "$WORKDIR" | grep '.mozjpeg.jpg')" ]]; then
          echo
          echo "------------------------------------------------------------------------------"
          echo "Optimised Jpg Images (mozjpeg):"
          echo "------------------------------------------------------------------------------"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
          if [[ "$COMPARE_MODE" = [yY] ]]; then
            cat "$LOG_PROFILE" | egrep -v ".webp :|.png :" | grep '.mozjpeg.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          else
            cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.png :" | grep '.mozjpeg.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          fi
        fi
      fi # check for mozjpeg tagged images first too
    fi
  
    if [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] && "$GUETZLI_JPEGONLY" = [yY] && "$MOZJPEG_JPEGONLY" = [yY] ]]; then
      if [[ "$(ls "$WORKDIR" | grep '.guetzli.jpg')" && "$(ls "$WORKDIR" | grep '.mozjpeg.jpg')" ]]; then
        echo
        echo "------------------------------------------------------------------------------"
        echo "Optimised Jpg Images (jpegoptim):"
        echo "------------------------------------------------------------------------------"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
        printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
        if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | egrep -v ".webp :|.mozjpeg.jpg :|.guetzli.jpg :|.png :" | grep "$COMPARE_SUFFIX" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        else
        cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.mozjpeg.jpg :|.guetzli.jpg :|.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
        fi
  
        if [[ "$(ls "$WORKDIR" | grep '.guetzli.jpg')" ]]; then
          echo
          echo "------------------------------------------------------------------------------"
          echo "Optimised Jpg Images (guetzli):"
          echo "------------------------------------------------------------------------------"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
          if [[ "$COMPARE_MODE" = [yY] ]]; then
            cat "$LOG_PROFILE" | egrep -v ".webp :|.png :|.mozjpeg.jpg :" | grep '.guetzli.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          else
            cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.png :|.mozjpeg.jpg :" | grep '.guetzli.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | % -18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          fi
        fi

        if [[ "$(ls "$WORKDIR" | grep '.mozjpeg.jpg')" ]]; then
          echo
          echo "------------------------------------------------------------------------------"
          echo "Optimised Jpg Images (mozjpeg):"
          echo "------------------------------------------------------------------------------"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
          printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
          if [[ "$COMPARE_MODE" = [yY] ]]; then
            cat "$LOG_PROFILE" | egrep -v ".webp :|.png :" | grep '.mozjpeg.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          else
            cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.png :" | grep '.mozjpeg.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
          fi
        fi
      fi # check for guetzli and mozjpeg tagged images first too
    fi
  
    if [[ "$GM_USE" != [yY] ]]; then
      echo
      echo "------------------------------------------------------------------------------"
      echo "ImageMagick Resource Limits"
      echo "------------------------------------------------------------------------------"
      echo "Version: $IMAGICK_VERSION"
      $IDENTIFY_BIN -list resource
      echo "------------------------------------------------------------------------------"
    else
      echo
    fi
  fi # LOGONLY
    }
    endtime=$(TZ=UTC date +%s.%N)
    processtime=$(echo "scale=2;$endtime - $starttime"|bc)
    echo "Completion Time: $(printf "%0.2f\n" $processtime) seconds"
    echo "------------------------------------------------------------------------------"
}

optimiser() {
  WORKDIR=$1
  CONTINUE=$2
  if [[ "$CONTINUE" = 'yes' ]]; then
    havebackup='y'
  else
    echo
    echo "!!! Important !!!"
    echo
    read -ep "Have you made a backup of images in $WORKDIR? [y/n]: " havebackup
    if [[ "$havebackup" != [yY] ]]; then
      echo
      echo "Please backup $WORKDIR before optimising images"
      echo "aborting..."
      echo
      exit
    fi
  fi
  if [[ "$havebackup" = [yY] ]]; then
  starttime=$(TZ=UTC date +%s.%N)
  {

  echo
  echo "------------------------------------------------------------------------------"
  echo "image optimisation start"
  echo "------------------------------------------------------------------------------"
  cd "$WORKDIR"
  if [[ "$THUMBNAILS" = [yY] ]]; then
    mkdir -p "$THUMBNAILS_DIRNAME"
  fi
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | while read i; do 
    file=$(basename "${i}")
    extension="${file##*.}"
    filename="${file%.*}"
    if [[ "$COMPARE_MODE" = [yY] && "OPTIPNG" = [yY] && "$ZOPFLIPNG" = [yY] ]]; then
      filein="${filename}${COMPARE_SUFFIX}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$COMPARE_MODE" = [yY] && "$GUETZLI" = [nN] && "$IMAGICK_RESIZE" = [yY] ]]; then
      filein="${filename}${COMPARE_SUFFIX}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$COMPARE_MODE" = [yY] && "$GUETZLI" = [yY] ]]; then
      filein="${filename}${COMPARE_SUFFIX}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$COMPARE_MODE" = [yY] && "$extension" = 'jpg' && "$JPEGOPTIM" = [yY] && "$IMAGICK_RESIZE" = [nN] ]]; then
      filein="${filename}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.noresize.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$extension" = 'jpg' && "$JPEGOPTIM" = [yY] && "$IMAGICK_RESIZE" = [nN] ]]; then
      filein="${filename}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.noresize.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$COMPARE_MODE" = [yY] && "$IMAGICK_RESIZE" = [nN] ]]; then
      filein="${filename}.${extension}"
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      jfilein="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
      jfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    else
      filein="${filename}.${extension}"
      fileout="${filename}.${extension}"
      gfilein="${filename}.${extension}"
      jfilein="${filename}.${extension}"
      gfileout="${filename}.${extension}"
      jfileout="${filename}.${extension}"
    fi
    echo "### $file ($extension) ###"
    IS_INTERLACED=$($IDENTIFY_BIN -verbose "${file}" | awk '/Interlace/ {print $2}')
    IS_TRANSPARENT=$($IDENTIFY_BIN -format "%A" "${file}")
    IS_TRANSPARENTCOLOR=$($IDENTIFY_BIN -verbose "${file}" | awk '/Transparent color/ {print $3}')
    if [[ "$GM_USE" != [yY] ]]; then
      IS_BACKGROUNDCOLOR=$($IDENTIFY_BIN -verbose "${file}" | awk '/Background Color: / {print $3}')
    else
      IS_BACKGROUNDCOLOR=$($IDENTIFY_BIN -verbose "${file}" | awk '/Background color: / {print $3}')
    fi
    # GraphicsMagick returns No vs ImageMagick returns None
    if [[ "$IS_INTERLACED" = 'None' || "$IS_INTERLACED" = 'No' ]]; then
      INTERLACE_OPT=' -interlace none'
      JPEGOPTIM_PROGRESSIVE=''
    elif [[ "$IS_INTERLACED" = 'JPEG' || "$IS_INTERLACED" = 'PNG' ]]; then
      INTERLACE_OPT=' -interlace plane'
      JPEGOPTIM_PROGRESSIVE=' --all-progressive'
    else
      INTERLACE_OPT=""
      JPEGOPTIM_PROGRESSIVE=''
    fi
    if [[ "$extension" = 'jpg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]] || [[ "$extension" = 'jpeg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        if [[ "$GM_USE" != [yY] ]]; then
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
        fi
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          if [[ "$GM_USE" != [yY] ]]; then
            echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp""
            ${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp"
          fi
        else
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    elif [[ "$extension" = 'png' && "$IMAGICK_RESIZE" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        if [[ "$GM_USE" != [yY] ]]; then
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
        fi
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          if [[ "$GM_USE" != [yY] ]]; then
            echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp""
            ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp"
          fi
        else
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    elif [[ "$IMAGICK_RESIZE" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        if [[ "$GM_USE" != [yY] ]]; then
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
        fi
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          if [[ "$GM_USE" != [yY] ]]; then
            echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp""
            ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
            -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
            "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.${extension}.webp"
          fi
        else
          echo "${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          ${CONVERT_BIN}${DEFINE_TMP} "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    fi
    if [[ "$extension" = 'png' ]]; then
      if [[ "$OPTIPNG" = [yY] && "$ZOPFLIPNG" = [yY] ]]; then
        echo "optipng -o${OPTIPNG_COMPRESSION} "${filein}" -preserve -out "${filename}.optipng.png""
        optipng -o${OPTIPNG_COMPRESSION} "${filein}" -preserve -out "${filename}.optipng.png"
        sar_call

        echo "zopflipng${ZOPFLIPNG_OPTS} "${filein}" "${filename}.zopflipng.png""
        zopflipng${ZOPFLIPNG_OPTS} "${filein}" "${filename}.zopflipng.png"
        sar_call
      elif [[ "$OPTIPNG" = [yY] && "$ZOPFLIPNG" = [nN] ]]; then
        echo "optipng -o${OPTIPNG_COMPRESSION} "${filein}" -preserve -out "${fileout}""
        optipng -o${OPTIPNG_COMPRESSION} "${filein}" -preserve -out "${fileout}"
        sar_call
      elif [[ "$ZOPFLIPNG" = [yY] && "$OPTIPNG" = [nN] ]]; then
        echo "zopflipng${ZOPFLIPNG_OPTS} "${filein}" "${fileout}""
        zopflipng${ZOPFLIPNG_OPTS} "${filein}" "${fileout}"
        sar_call
      fi
    elif [[ "$extension" = 'jpg' || "$extension" = 'jpeg' ]]; then
      # if set JPEGOPTIM='y' and GUETZLI='y' simultaneously, save Guetzli copy to separate file
      # to be able to compare with JPEGOPTIM optimised files
      if [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
        if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}"
          sar_call
          # copy and overwrite filename as jpegoptim errors out if you with stdout method
          mv -f "${fileout}" "${jfilein}"
          sar_call
        else
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}"
          sar_call
        fi

        echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${filename}.guetzli.jpg""
        $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${filename}.guetzli.jpg"
        sar_call

        echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.jpg" "${filein}""
        $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.jpg" "${filein}"
        sar_call
      elif [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
        if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}"
          sar_call
          # copy and overwrite filename as jpegoptim errors out if you with stdout method
          mv -f "${fileout}" "${jfilein}"
          sar_call
        else
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}"
          sar_call
        fi

        echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.jpg" "${filein}""
        $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.jpg" "${filein}"
        sar_call
      elif [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [nN] && "$GUETZLI" = [nN] ]]; then
        echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${fileout}" "${fileout}""
        $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${fileout}" "${fileout}"
        sar_call
      elif [[ "$MOZJPEG" = [nN] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
        if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}"
          sar_call
          # copy and overwrite filename as jpegoptim errors out if you with stdout method
          mv -f "${fileout}" "${jfilein}"
          sar_call
        else
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}"
          sar_call
        fi

        echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${filename}.guetzli.jpg""
        $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${filename}.guetzli.jpg"
        sar_call
      elif [[ "$MOZJPEG" = [nN] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
        if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" --stdout "${filein}" > "${fileout}"
          sar_call
          # copy and overwrite filename as jpegoptim errors out if you with stdout method
          mv -f "${fileout}" "${jfilein}"
          sar_call
        else
          echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}""
          jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$IMAGICK_QUALITY" "${filein}"
          sar_call
        fi
      elif [[ "$MOZJPEG" = [nN] && "$GUETZLI" = [yY] && "$JPEGOPTIM" = [nN] ]]; then
        echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${fileout}""
        $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filein}" "${fileout}"
        sar_call
      fi
    fi

    # check thumbnail image info
    tn_file=$(basename "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}")
    tn_extension="${tn_file##*.}"
    tn_filename="${tn_file%.*}"
    if [[ "$THUMBNAILS" = [yY] ]]; then
      echo "pushd ${THUMBNAILS_DIRNAME}"
      pushd ${THUMBNAILS_DIRNAME}
      if [[ "$tn_extension" = 'png' ]]; then
        if [[ "$OPTIPNG" = [yY] && "$ZOPFLIPNG" = [yY] ]]; then
          echo "optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.optipng.${THUMBNAILS_FORMAT}""
          optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.optipng.${THUMBNAILS_FORMAT}"
          sar_call

          echo "zopflipng${ZOPFLIPNG_OPTS} "${filename}.${THUMBNAILS_FORMAT}" "${filename}.zopflipng.${THUMBNAILS_FORMAT}""
          zopflipng${ZOPFLIPNG_OPTS} "${filename}.${THUMBNAILS_FORMAT}" "${filename}.zopflipng.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$OPTIPNG" = [yY] && "$ZOPFLIPNG" = [nN] ]]; then
          echo "optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.${THUMBNAILS_FORMAT}""
          optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$ZOPFLIPNG" = [yY] && "$OPTIPNG" = [nN] ]]; then
          echo "zopflipng${ZOPFLIPNG_OPTS} "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          zopflipng${ZOPFLIPNG_OPTS} "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        fi
      elif [[ "$tn_extension" = 'jpg' || "$tn_extension" = 'jpeg' ]]; then
        # if set JPEGOPTIM='y' and GUETZLI='y' simultaneously, save Guetzli copy to separate file
        # to be able to compare with JPEGOPTIM optimised files
        if [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
          if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          else
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          fi

          echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}""
          $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}"
          sar_call

          echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
          if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          else
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          fi

          echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.mozjpeg.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$MOZJPEG" = [yY] && "$JPEGOPTIM" = [nN] && "$GUETZLI" = [nN] ]]; then
          echo "$MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          $MOZJPEG_BIN"${MOZJPEG_QUALITY}" "$MOZJPEG_OPTS" -outfile "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$MOZJPEG" = [nN] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
          if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          else
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          fi

          echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}""
          $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}"
          sar_call       
        elif [[ "$MOZJPEG" = [nN] && "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
          if [[ "$IMAGICK_RESIZE" = [nN] ]]; then
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" --stdout "${filename}.${THUMBNAILS_FORMAT}" > "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          else
            echo "jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
            jpegoptim${JPEGOPTIM_PROGRESSIVE} -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
            sar_call
          fi
        elif [[ "$MOZJPEG" = [nN] && "$GUETZLI" = [yY] && "$JPEGOPTIM" = [nN] ]]; then
          echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        fi
      fi
      popd
    fi
  done
  echo "------------------------------------------------------------------------------"
  }
  endtime=$(TZ=UTC date +%s.%N)
  processtime=$(echo "scale=2;$endtime - $starttime"|bc)
  echo "Completion Time: $(printf "%0.2f\n" $processtime) seconds"
  echo "------------------------------------------------------------------------------"
  fi
}

benchmark() {
  bstarttime=$(TZ=UTC date +%s.%N)
  {
  ALL=$1
  if [[ "$ALL" = 'all' ]]; then
    TESTFILES_MINIMAL='n'
  fi
  echo "Benchmark Starting..."
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  IMAGICK_WEBP='n'
  COMPARE_MODE='n'
  rm -rf "$BENCHDIR"
  mkdir -p "$BENCHDIR"
  testfiles "$BENCHDIR"
  profiler "$BENCHDIR"
  optimiser "$BENCHDIR" yes
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  profiler "$BENCHDIR"
  }
  bendtime=$(TZ=UTC date +%s.%N)
  bprocesstime=$(echo "scale=2;$bendtime - $bstarttime"|bc)
  echo
  echo "------------------------------------------------------------------------------"
  echo "Benchmarked Completeion Time: $(printf "%0.2f\n" $bprocesstime) seconds"
  echo "------------------------------------------------------------------------------"
}

benchmark_compare() {
  bcstarttime=$(TZ=UTC date +%s.%N)
  {
  ALL=$1
  if [[ "$ALL" = 'all' ]]; then
    TESTFILES_MINIMAL='n'
  fi
  echo "Benchmark Starting..."
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  IMAGICK_WEBP='n'
  COMPARE_MODE='y'
  rm -rf "$BENCHDIR"
  mkdir -p "$BENCHDIR"
  testfiles "$BENCHDIR"
  profiler "$BENCHDIR"
  optimiser "$BENCHDIR" yes
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  profiler "$BENCHDIR"
  }
  bcendtime=$(TZ=UTC date +%s.%N)
  bcprocesstime=$(echo "scale=2;$bcendtime - $bcstarttime"|bc)
  echo
  echo "------------------------------------------------------------------------------"
  echo "Benchmarked Completeion Time: $(printf "%0.2f\n" $bcprocesstime) seconds"
  echo "------------------------------------------------------------------------------"
}

benchmark_webp() {
  wstarttime=$(TZ=UTC date +%s.%N)
  {
  ALL=$1
  if [[ "$ALL" = 'all' ]]; then
    TESTFILES_MINIMAL='n'
  fi
  echo "Benchmark Starting..."
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  IMAGICK_WEBP='y'
  COMPARE_MODE='n'
  rm -rf "$BENCHDIR"
  mkdir -p "$BENCHDIR"
  testfiles "$BENCHDIR"
  profiler "$BENCHDIR"
  optimiser "$BENCHDIR" yes
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  profiler "$BENCHDIR"
  }
  wendtime=$(TZ=UTC date +%s.%N)
  wprocesstime=$(echo "scale=2;$wendtime - $wstarttime"|bc)
  echo
  echo "------------------------------------------------------------------------------"
  echo "Benchmarked Completeion Time: $(printf "%0.2f\n" $wprocesstime) seconds"
  echo "------------------------------------------------------------------------------"
}

benchmark_comparewebp() {
  cwstarttime=$(TZ=UTC date +%s.%N)
  {
  ALL=$1
  if [[ "$ALL" = 'all' ]]; then
    TESTFILES_MINIMAL='n'
  fi
  echo "Benchmark Starting..."
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  IMAGICK_WEBP='y'
  COMPARE_MODE='y'
  rm -rf "$BENCHDIR"
  mkdir -p "$BENCHDIR"
  testfiles "$BENCHDIR"
  profiler "$BENCHDIR"
  optimiser "$BENCHDIR" yes
  DT=$(date +"%d%m%y-%H%M%S")
  LOGNAME_PROFILE="profile-log-${DT}.log"
  LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
  profiler "$BENCHDIR"
  }
  cwendtime=$(TZ=UTC date +%s.%N)
  cwprocesstime=$(echo "scale=2;$cwendtime - $cwstarttime"|bc)
  echo
  echo "------------------------------------------------------------------------------"
  echo "Benchmarked Completeion Time: $(printf "%0.2f\n" $cwprocesstime) seconds"
  echo "------------------------------------------------------------------------------"
}

###############
case "$1" in
  optimise)
    DIR=$2
    if [ -d "$DIR" ]; then
      optimiser "$DIR"
    fi
    ;;
  profile)
    DIR=$2
    profiler "$DIR"
    ;;
  profilelog)
    DIR=$2
    profiler "$DIR" logonly
    ;;
  testfiles)
    DIR=$2
    testfiles "$DIR"
    ;;
  install)
    install_source
    guetzli_install
    mozjpeg_install
    butteraugli_install
    ;;
  bench)
    ALL=$2
    if [[ "$ALL" = 'all' ]]; then
      benchmark all
    else
      benchmark
    fi
    ;;
  bench-compare)
    ALL=$2
    if [[ "$ALL" = 'all' ]]; then
      benchmark_compare all
    else
      benchmark_compare
    fi
    ;;
  bench-webp)
    ALL=$2
    if [[ "$ALL" = 'all' ]]; then
      benchmark_webp all
    else
      benchmark_webp
    fi
    ;;
  bench-webpcompare)
    ALL=$2
    if [[ "$ALL" = 'all' ]]; then
      benchmark_comparewebp all
    else
      benchmark_comparewebp
    fi
    ;;
    *)
    echo "$0 {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {profile} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {profilelog} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {install}"
    echo "$0 {bench}"
    echo "$0 {bench-compare}"
    echo "$0 {bench-webp}"
    echo "$0 {bench-webpcompare}"
    echo "$0 {bench} all"
    echo "$0 {bench-compare} all"
    echo "$0 {bench-webp} all"
    echo "$0 {bench-webpcompare} all"
    ;;
esac

exit