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
# http://www.imagemagick.org/script/architecture.php
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
# test images
# https://testimages.org/
########################################################################
DT=$(date +"%d%m%y-%H%M%S")
VER='1.7'
DEBUG='y'

# control sample image downloads
# allows you to control how many sample images to work with/download
# guetzli testing is very resource and time consuming so working with
# a smaller sample image set would be better
TESTFILES_MINIMAL='y'

# max width and height
MAXRES='2048'

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
IMAGICK_JPGOPTS=' -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045'
IMAGICK_PNGOPTS=' -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2'
IMAGICK_WEBPOPTS=" -define webp:method=${IMAGICK_WEBPMETHOD} -define webp:alpha-quality=${IMAGICK_WEBPQUALITYALPHA} -define webp:lossless=false -quality ${IMAGICK_WEBPQUALITY}"

# strip meta-data
STRIP='y'

# additional image optimisations after imagemagick
# resizing
JPEGOPTIM='y'
GUETZLI='n'
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
THUMBNAILS_QUALITY='72'
THUMBNAILS_WIDTH='150'
THUMBNAILS_HEIGHT='150'
THUMBNAILS_FORMAT='jpg'
THUMBNAILS_DIRNAME='thumbnails'

LOGDIR='/home/optimise-logs'
LOGNAME_PROFILE="profile-log-${DT}.log"
LOG_PROFILE="${LOGDIR}/${LOGNAME_PROFILE}"
BENCHDIR='/home/optimise-benchmarks'

GUETZLI_BIN='/opt/guetzli/bin/Release/guetzli'
########################################################################
# DO NOT EDIT BELOW THIS POINT

# Binary paths
if [[ "$IMAGICK_SEVEN" = [yY] && -f /opt/imagemagick7/bin/identify ]]; then
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
  OPTIPNG='n'
  echo "installed zopflipng"
elif [[ "$ZOPFLIPNG" = [yY] && -f /usr/bin/zopflipng ]]; then
  OPTIPNG='n'
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

if [[ "$GUETZLI" = [yY] && ! -f /usr/bin/libpng-config && ! -f /opt/guetzli/bin/Release/guetzli ]]; then
  yum -q -y install libpng-devel
  guetzli_install
elif [[ "$GUETZLI" = [yY] && -f /usr/bin/libpng-config && ! -f /opt/guetzli/bin/Release/guetzli ]]; then
  guetzli_install
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
  wget -cnv -O bees.png https://github.com/centminmod/optimise-images/raw/master/images/bees.png
  wget -cnv -O samsung_s7_mobile_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/samsung_s7_mobile_1.jpg
  wget -cnv -O dslr_canon_eos_m6_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_canon_eos_m6_1.jpg
  wget -cnv -O webp-study-source-firebreathing.png https://github.com/centminmod/optimise-images/raw/master/images/webp-study-source-firebreathing.png
  wget -cnv -O png24-image1.png https://github.com/centminmod/optimise-images/raw/master/images/png24-image1.png
  wget -cnv -O png24-interlaced-image1.png https://github.com/centminmod/optimise-images/raw/master/images/png24-interlaced-image1.png
  if [[ "$TESTFILES_MINIMAL" != [yY] ]]; then
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
    wget -cnv -O dslr_nikon_d7200_1.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d7200_1.jpg
    wget -cnv -O dslr_nikon_d7200_2.jpg https://github.com/centminmod/optimise-images/raw/master/images/dslr_nikon_d7200_2.jpg
    cp image4.jpg "im age5.jpg"
    wget -cnv -O webp-study-source-google-chart-tools.png https://github.com/centminmod/optimise-images/raw/master/images/webp-study-source-google-chart-tools.png
    wget -cnv -O pngimage1.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage1.png
    wget -cnv -O pngimage2.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage2.png
    wget -cnv -O pngimage3.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage3.png
    wget -cnv -O pngimage4.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage4.png
    wget -cnv -O screenshot1.png https://github.com/centminmod/optimise-images/raw/master/images/screenshot1.png
    wget -cnv -O lenna.png https://github.com/centminmod/optimise-images/raw/master/images/lenna.png
  fi
  echo
  ls -lah "$WORKDIR"
}

profiler() {
  starttime=$(TZ=UTC date +%s.%N)
  {
  WORKDIR=$1
  echo
  echo "------------------------------------------------------------------------------"
  echo "image profile"
  if [[ "$PROFILE_EXTEND" = [yY] ]]; then
    echo "image name : width : height : quality : transparency : image depth (bits) : size : user: group : transparency color : background color"
  else
    echo "image name : width : height : quality : transparency : image depth (bits) : size : user: group"
  fi
  echo "------------------------------------------------------------------------------"
  echo "images in $WORKDIR"
  echo "logged at $LOG_PROFILE"
  echo "------------------------------------------------------------------------------"
  cd "$WORKDIR"
  {
  if [[ "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" | sort | while read i; do
    file=$(basename "${i}")
    echo -n "image : "$file" : ";
    echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %z :' "$file") ";
    if [[ "$PROFILE_EXTEND" = [yY] ]]; then
      echo -n "$(stat -c "%s : %U : %G" "$file") : ";
      echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
      echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Background color: / {print $3}')";
    else
      echo "$(stat -c "%s : %U : %G" "$file")";
    fi
    done
  else
    find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do
    file=$(basename "${i}")
    echo -n "image : "$file" : ";
    echo -n "$($IDENTIFY_BIN -format '%w : %h : %Q : %A : %z :' "$file") ";
    if [[ "$PROFILE_EXTEND" = [yY] ]]; then
      echo -n "$(stat -c "%s : %U : %G" "$file") : ";
      echo -n "$($IDENTIFY_BIN -verbose "$file" | awk '/Transparent color/ {print $3}') : ";
      echo "$($IDENTIFY_BIN -verbose "$file" | awk '/Background color: / {print $3}')";
    else
      echo "$(stat -c "%s : %U : %G" "$file")";
    fi
    done
  fi
  } 2>&1 | tee "$LOG_PROFILE"

  echo
  echo "------------------------------------------------------------------------------"
  echo "Original or Existing Images:"
  echo "------------------------------------------------------------------------------"
  printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
  printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
  # optimise routine so no need to do a find - sort - while loop again instead rely on the
  # tee $LOG_PROFILE log created earlier to get image statistics and information
  if [[ "$COMPARE_MODE" = [yY] && "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
  elif [[ "$COMPARE_MODE" = [nN] && "$IMAGICK_WEBP" = [yY] && "$(ls "$WORKDIR" | grep '.webp')" ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
  elif [[ "$COMPARE_MODE" = [nN] && "$IMAGICK_WEBP" = [nN] ]]; then
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
  else
    cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
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

  if [[ "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] && "$GUETZLI_JPEGONLY" = [yY] ]]; then
      echo
      echo "------------------------------------------------------------------------------"
      echo "Optimised Jpg Images (jpegoptim):"
      echo "------------------------------------------------------------------------------"
      printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
      printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
      if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | egrep -v ".webp :|.guetzli.jpg :|.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
      else
        cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.guetzli.jpg :|.png :" | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
      fi

      echo
      echo "------------------------------------------------------------------------------"
      echo "Optimised Jpg Images (guetzli):"
      echo "------------------------------------------------------------------------------"
      printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "Avg width" "Avg height" "Avg quality" "Avg size" "Total size (Bytes)" "Total size (KB)"
      printf "| %-9s | %-10s | %-11s | %-10s | %-18s | %-15s |\n" "---------" "----------" "-----------" "--------" "------------------" "---------------"
      if [[ "$COMPARE_MODE" = [yY] ]]; then
        cat "$LOG_PROFILE" | egrep -v ".webp :|.png :" | grep '.guetzli.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
      else
        cat "$LOG_PROFILE" | egrep -v "$COMPARE_SUFFIX|.webp :|.png :" | grep '.guetzli.jpg :' | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8; tb = c8; tk = c8} END {printf "| %-9.0f | %-10.0f | %-11.0f | %-10.0f | %-18.0f | %-15.0f |\n", c3/NR, c4/NR, c5/NR, c8/NR, tb, tk/1024}'
      fi
  fi

  echo
  echo "------------------------------------------------------------------------------"
  echo "ImageMagick Resource Limits"
  echo "------------------------------------------------------------------------------"
  echo "Version: $IMAGICK_VERSION"
  $IDENTIFY_BIN -list resource
  echo "------------------------------------------------------------------------------"
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
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do 
    file=$(basename "${i}")
    extension="${file##*.}"
    filename="${file%.*}"
    if [[ "$COMPARE_MODE" = [yY] && "$GUETZLI" = [nN] ]]; then
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    elif [[ "$COMPARE_MODE" = [yY] && "$GUETZLI" = [yY] ]]; then
      fileout="${filename}${COMPARE_SUFFIX}.${extension}"
      gfileout="${filename}${COMPARE_SUFFIX}.${extension}"
    else
      fileout="$file"
    fi
    echo "### $file ($extension) ###"
    IS_INTERLACED=$($IDENTIFY_BIN -verbose "${file}" | awk '/Interlace/ {print $2}')
    IS_TRANSPARENT=$($IDENTIFY_BIN -format "%A" "${file}")
    IS_TRANSPARENTCOLOR=$($IDENTIFY_BIN -verbose "${file}" | awk '/Transparent color/ {print $3}')
    IS_BACKGROUNDCOLOR=$($IDENTIFY_BIN -verbose "${file}" | awk '/Background color: / {print $3}')
    if [[ "$IS_INTERLACED" = 'None' ]]; then
      INTERLACE_OPT=' -interlace none'
    else
      INTERLACE_OPT=""
    fi
    if [[ "$extension" = 'jpg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]] || [[ "$extension" = 'jpeg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
        $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp"
        else
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${JPEGHINT_OPT}${IMAGICK_JPGOPTS}${INTERLACE_OPT}${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    elif [[ "$extension" = 'png' && "$IMAGICK_RESIZE" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
        $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp"
        else
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT}${IMAGICK_PNGOPTS} -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    elif [[ "$IMAGICK_RESIZE" = [yY] ]]; then
      if [[ "$THUMBNAILS" = [yY] ]]; then
        echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}""
        $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
        -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
        "mpr:$filename" -thumbnail '150x150>' -unsharp 0x.5 "${THUMBNAILS_DIRNAME}/${filename}.${THUMBNAILS_FORMAT}"
      else
        if [[ "$IMAGICK_WEBP" = [yY] ]]; then
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" \
          -write "mpr:$filename" -resize ${MAXRES}x${MAXRES}\> -write "${fileout}" +delete \
          "mpr:$filename"${IMAGICK_WEBPTHREADSOPTS}${IMAGICK_WEBPOPTS} -resize ${MAXRES}x${MAXRES}\> "${filename}.webp"
        else
          echo "$CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" -resize ${MAXRES}x${MAXRES}\> "${fileout}""
          $CONVERT_BIN -define registry:temporary-path="${IMAGICK_TMPDIR}" "${file}"${INTERLACE_OPT}${STRIP_OPT} -quality "$IMAGICK_QUALITY" -resize ${MAXRES}x${MAXRES}\> "${fileout}"
        fi
      sar_call
      fi
    fi
    if [[ "$extension" = 'png' ]]; then
      if [[ "$OPTIPNG" = [yY] ]]; then
        echo "optipng -o${OPTIPNG_COMPRESSION} "${fileout}" -preserve -out "${fileout}""
        optipng -o${OPTIPNG_COMPRESSION} "${fileout}" -preserve -out "${fileout}"
        sar_call
      fi
      if [[ "$ZOPFLIPNG" = [yY] ]]; then
        echo "zopflipng -y --iterations=1 "${fileout}" "${fileout}""
        zopflipng -y --iterations=1 "${fileout}" "${fileout}"
        sar_call
      fi
    elif [[ "$extension" = 'jpg' || "$extension" = 'jpeg' ]]; then
      # if set JPEGOPTIM='y' and GUETZLI='y' simultaneously, save Guetzli copy to separate file
      # to be able to compare with JPEGOPTIM optimised files
      if [[ "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
        echo "jpegoptim -p --max="$IMAGICK_QUALITY" "${fileout}""
        jpegoptim -p --max="$IMAGICK_QUALITY" "${fileout}"
        sar_call

        echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${fileout}" "${filename}.guetzli.jpg""
        $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${fileout}" "${filename}.guetzli.jpg"
        sar_call
      elif [[ "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
        echo "jpegoptim -p --max="$IMAGICK_QUALITY" "${fileout}""
        jpegoptim -p --max="$IMAGICK_QUALITY" "${fileout}"
        sar_call
      elif [[ "$GUETZLI" = [yY] && "$JPEGOPTIM" = [nN] ]]; then
        echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${fileout}" "${fileout}""
        $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${fileout}" "${fileout}"
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
        if [[ "$OPTIPNG" = [yY] ]]; then
          echo "optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.${THUMBNAILS_FORMAT}""
          optipng -o${OPTIPNG_COMPRESSION} "${filename}.${THUMBNAILS_FORMAT}" -preserve -out "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        fi
        if [[ "$ZOPFLIPNG" = [yY] ]]; then
          echo "zopflipng -y --iterations=1 "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}""
          zopflipng -y --iterations=1 "${filename}.${THUMBNAILS_FORMAT}" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        fi
      elif [[ "$tn_extension" = 'jpg' || "$tn_extension" = 'jpeg' ]]; then
        # if set JPEGOPTIM='y' and GUETZLI='y' simultaneously, save Guetzli copy to separate file
        # to be able to compare with JPEGOPTIM optimised files
        if [[ "$JPEGOPTIM" = [yY] && "$GUETZLI" = [yY] ]]; then
          echo "jpegoptim -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
          jpegoptim -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call

          echo "$GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}""
          $GUETZLI_BIN --quality "$GUETZLI_QUALITY" "$GUETZLI_OPTS" "${filename}.${THUMBNAILS_FORMAT}" "${filename}.guetzli.${THUMBNAILS_FORMAT}"
          sar_call            
        elif [[ "$JPEGOPTIM" = [yY] && "$GUETZLI" = [nN] ]]; then
          echo "jpegoptim -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}""
          jpegoptim -p --max="$THUMBNAILS_QUALITY" "${filename}.${THUMBNAILS_FORMAT}"
          sar_call
        elif [[ "$GUETZLI" = [yY] && "$JPEGOPTIM" = [nN] ]]; then
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
  testfiles)
    DIR=$2
    testfiles "$DIR"
    ;;
  install)
    install_source
    guetzli_install
    ;;
  bench)
    benchmark
    ;;
  bench-compare)
    benchmark_compare
    ;;
  bench-webp)
    benchmark_webp
    ;;
  bench-webpcompare)
    benchmark_comparewebp
    ;;
    *)
    echo "$0 {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {profile} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {install}"
    echo "$0 {bench}"
    echo "$0 {bench-compare}"
    echo "$0 {bench-webp}"
    echo "$0 {bench-webpcompare}"
    ;;
esac

exit