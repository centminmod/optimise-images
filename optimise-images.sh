#! /bin/bash
########################################################################
# batch optimise images
# written by George Liu (eva2000) centminmod.com
########################################################################
DEBUG='y'
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'
OPTIPNG='y'
JPEGOPTIM='y'
ZOPFLIPNG='n'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'

RESIZEDIR_NAME='z_resized'
########################################################################
#
if [ -f /proc/user_beancounters ]; then
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`    
else
    # speed up make
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`    
fi

if [ ! -f /usr/bin/optipng ]; then
  yum -q -y install optipng
fi

if [ ! -f /usr/bin/jpegoptim ]; then
  yum -q -y install jpegoptim
fi

if [[ "$ZOPFLIPNG" = [yY] && ! -f /usr/bin/zopflipng ]]; then
  mkdir -p /opt/zopfli
  cd /opt/zopfli
  git clone https://github.com/google/zopfli
  cd zopfli/
  make -s -j2
  make -s zopflipng
  make -s libzopfli
  \cp -f zopflipng /usr/bin/zopflipng
  OPTIPNG='n'
elif [[ "$ZOPFLIPNG" = [yY] && -f /usr/bin/zopflipng ]]; then
  OPTIPNG='n'
fi

if [[ "$STRIP" = [Yy] ]]; then
  STRIP_OPT=' -strip'
else
  STRIP_OPT=""
fi
##########################################################################
# function

testfiles() {
  WORKDIR=$1
  cd "$WORKDIR"
  wget -cnv -O image1.jpg https://github.com/centminmod/optimise-images/raw/master/images/image1.jpg
  wget -cnv -O image2.jpg https://github.com/centminmod/optimise-images/raw/master/images/image2.jpg
  wget -cnv -O image3.jpg https://github.com/centminmod/optimise-images/raw/master/images/image3.jpg
  wget -cnv -O image4.jpg https://github.com/centminmod/optimise-images/raw/master/images/image4.jpg
  cp image4.jpg "im age5.jpg"
  wget -cnv -O pngimage1.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage1.png
  wget -cnv -O pngimage2.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage2.png
  wget -cnv -O pngimage3.png https://github.com/centminmod/optimise-images/raw/master/images/pngimage3.png
}

profiler() {
  WORKDIR=$1
  echo
  echo "-------------------------------------------------------------------------"
  echo "image profile"
  echo "image name : width : height : quality : transparency : image depth (bits) : size : user: group"
  echo "-------------------------------------------------------------------------"
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do 
   echo -n "image : "$i" : ";
   echo -n "$(identify -format '%w : %h : %Q : %A : %z :' "$i") ";
   echo "$(stat -c "%s : %U : %G" "$i")";
  done

  echo
  echo "-------------------------------------------------------------------------"
  echo "average image width, height, image quality and size"
  echo "-------------------------------------------------------------------------"
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do echo -n "image : "$i" : ";
   echo -n "$(identify -format '%w : %h : %Q : %A : %z :' "$i") ";
   echo "$(stat -c "%s : %U : %G" "$i")";
  done  | awk -F " : " '{c3 += $3; c4 += $4; c5 += $5; c8 += $8} END {print c3/NR" "c4/NR" "c5/NR" "c8/NR}'

  echo
  echo "-------------------------------------------------------------------------"
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do echo -n "image : "$i" : ";
   echo -n "$(identify -format '%w : %h : %Q : %A : %z :' "$i") ";
   echo "$(stat -c "%s : %U : %G" "$i")";
  done  | awk -F " : " '{c8 += $8} END {print "Total Image Size: "c8,"Bytes",c8/1024,"KB"}'
  echo "-------------------------------------------------------------------------"
}

optimiser() {
  WORKDIR=$1

  echo
  echo "-------------------------------------------------------------------------"
  echo "image optimisation start"
  echo "-------------------------------------------------------------------------"
  cd "$WORKDIR"
  find "$WORKDIR" -maxdepth 1 -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" | sort | while read i; do 
    file=$(basename "${i}")
    extension="${file##*.}"
    filename="${file%.*}"
    echo "$file ($extension)"
    if [[ "$extension" = 'jpg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]] || [[ "$extension" = 'jpeg' && "$IMAGICK_RESIZE" = [yY] && "$JPEGOPTIM" = [yY] ]]; then
      echo "convert "${file}" -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.25+8+0.065 -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${file}""
      convert "${file}" -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> "${file}"
    elif [[ "$extension" = 'png' && "$IMAGICK_RESIZE" = [yY] ]]; then
      echo "convert "${file}" -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=3 "${file}""
      convert "${file}" -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 "${file}"
    elif [[ "$IMAGICK_RESIZE" = [yY] ]]; then
      echo "convert "${file}" -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> -quality "$IMAGICK_QUALITY" "${file}""
      convert "${file}" -interlace none${STRIP_OPT} -resize ${MAXRES}x${MAXRES}\> -quality "$IMAGICK_QUALITY" "${file}"
    fi
    if [[ "$extension" = 'png' ]]; then
      if [[ "$OPTIPNG" = [yY] ]]; then
        echo "optipng -o2 "${file}" -preserve -out "${file}""
        optipng -o2 "${file}" -preserve -out "${file}"
      fi
      if [[ "$ZOPFLIPNG" = [yY] ]]; then
        echo "zopflipng -y --iterations=1 "${file}" "${file}""
        zopflipng -y --iterations=1 "${file}" "${file}"
      fi
    elif [[ "$extension" = 'jpg' || "$extension" = 'jpeg' ]]; then
      if [[ "$JPEGOPTIM" = [yY] ]]; then
        echo "jpegoptim -p --max="$IMAGICK_QUALITY" "${file}""
        jpegoptim -p --max="$IMAGICK_QUALITY" "${file}"
      fi
    fi
  done
  echo "-------------------------------------------------------------------------"
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
    *)
    echo "$0 {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {profile} /PATH/TO/DIRECTORY/WITH/IMAGES"
    echo "$0 {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES"
    ;;
esac

exit