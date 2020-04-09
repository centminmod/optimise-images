optimise-images.sh
======

Batch jpg, jpeg and png image resizer, optimiser and image profiler using [ImageMagick](https://www.imagemagick.org/script/index.php) convert, [OptiPNG](http://optipng.sourceforge.net/), [JpegOptim](https://github.com/tjko/jpegoptim) and optional [Mozilla MozJPEG](https://github.com/mozilla/mozjpeg), [ZopfliPNG](https://github.com/google/zopfli) and [Google Guetzli](https://github.com/google/guetzli) (work in progress for Guetzli).

* [Install](#install)
* [Features](#features)
* [Requirements](#requirements)
* [optimise-images.ini settings file](#optimise-imagesini-settings)
* [Other Examples](#other-examples)
* [Example Optimisation](#example-optimisation)
* [Unattended Subdirectory Runs](#unattended-subdirectory-runs)
* [Dockerfile](#dockerfile)
  * [Building the Docker Image From Dockerfile](#building-the-docker-image-from-dockerfile)
    * [Manual docker build](#manual-docker-build)
    * [Via dockerbuild.sh](#via-dockerbuildsh)

Install
===============

To install at `/root/tools` where script full path will be  `/root/tools/optimise-images/optimise-images.sh` or change directory location of your choice

```
mkdir -p /root/tools
cd /root/tools
git clone --depth=1 https://github.com/centminmod/optimise-images
```

Features
===============

* Profiler mode allows you to point the script to a directory of images and for JPG, JPEG and PNG files will profile and gather individual image's information such as image name, width, height, size, colour depth, whether it's a transparent image, image user/group permissions etc. Optionally, you can set `PROFILE_EXTEND='y'` to also display each individual images transparent and background colours. For processing speed, these are disabled by default with `PROFILE_EXTEND='n'`.
* The profiler runs are logged to directory defined by `LOGDIR='/home/optimise-logs'` so you can use command line tools like grep, awk etc to filter information or diff comparison tools to compare before and after optimisation profile logs. This allows you to double check the optimised and resized images retain their properties you require like image transparency or whether or not image is interlaced/progressive.
* Optimisation modes highlighted in examples linked below allow you to batch resize and optimise images as well as convert them to WebP format via tools such as ImageMagick, JpegOptim, OptiPNG and optionally support Mozilla MozJPEG, Google ZopfliPNG and Google Guetzli. Support for GraphicsMagick is still a work in progress though so is not fully supported for all  modes of operation.
* By default the resize and optimisation routines will check to see if an original image is transparent and/or is interlaced/progressive and will retain those image properties through the process.
* There are specific [optimisation modes](/examples/examples-optimise-webp-nginx-300417.md) which allow for more convenient conversions to WebP format - including automatic generation of a lazy load supported static html gallery displaying side by side, the optimised original versus the WebP converted image as well as [Ngnx syntax for WebP conditional serving](https://centminmod.com/webp/). You can turn off static html gallery generation via option `GALLERY_WEBP='n'`.
* Each optimise run will prompt user to ask if they have backed up their image directory prior to batch optimisation and resizing and is now controlled via variable `UNATTENDED_OPTIMISE='n'` which is set to default. You can skip the backup question prompt for more advanced scripted runs of `optimise-images.sh` by setting variable `UNATTENDED_OPTIMISE='y'`.
* [webP conversion mode](/examples/examples-optimise-webp-nginx-300417.md) - will only keep converted webP image file if the webP file is smaller than original image format. If webP image ends up larger in file size than original image file size, the webP file is removed.
* Benchmark modes highlighted in example links below, are testing methods coded to work to test the before optimisation profiling + optimisation + after optimisation profiling routines on a preset  directory of images.
* Running the script is timed so you get timed completion statistics information so you can measure the speed of profiling, optimisation and conversion.
* System resource usage logging is done via sysstat after each individual image processing so you can use sar command to understand the cpu, memory and disk usage profiles during or after the script runs.
* You can control nice and ionice priorities for the conversion and resize processes via variables `NICEOPT='-n 10'` and `IONICEOPT='-c2 -n7'` to either set a higher or lower priority.
* [profile-age & optimise-age Mode](examples/age-170817.md) allows you to filter and limit profiling and optimisation of images by image timestamp age.
* [optimise-cron & optimise-cron-age Mode](examples/cron-170817.md) for use in cronjob scheduled runs which removes the post-optimisation profile routine run to save time.
* [ADD_COMMENT variable](examples/skip-optimised-images-180817.md) optional variable when enabled `ADD_COMMENT='y'`, the script's ImageMagick routine will add to optimised images a comment = `optimised` marking optimised images. This will allow subsequent re-runs of script to detect the comment = `optimised` and skip re-optimising of the previously optimised image and only optimise unoptimised images. This will speed up the optimisation process on re-runs. Note setting `ADD_COMMENT='y'` will disable subsequent webP conversion runs if you had already ran `optimise-images.sh` on the same directory of files. So if you need to do webP conversions on subsequent runs on same directory, disable `ADD_COMMENT='n'` option first.

Requirements
===============

* ImageMagick 6+ or 7+
* CentOS Epel YUM repository
* CentOS/RHEL YUM install for `optipng` & `jpegoptim` 
* [Google Butteraugli](https://github.com/google/butteraugli) source installed automatically by `optimise-images.sh`
* `optimise-images.sh` will auto install via source compile if MozJPEG, `zopflipng` and/or `guetzli` is required
* Alternatively, use the supplied Dockerfile to build a Docker image and run using it [details](#dockerfile):

Optimise-Images.ini Settings
===============

* April 8, 2020: Add `optimise-images.ini` settings file support to override and customise `optimise-images.sh` settings. You create and place optimise-images.ini in same directory at optimise-images.sh for it to take effect. So if script is at `/root/tools/optimise-images/optimise-images.sh`, then place ini settings file at `/root/tools/optimise-images/optimise-images.ini`. Then in your `/root/tools/optimise-images/optimise-images.ini` you can place your customised settings that override the script's defaults:

Example

```
IMAGICK_QUALITY='82'
IMAGICK_WEBP='y'
IMAGICK_WEBPQUALITY='75'
IMAGICK_WEBPLOSSLESS='n'
```

Other Examples
===============

* [24/04/17 Example](examples/examples-240417.md)
* [25/04/17 New Option: Compare Mode](examples/compare_mode-250417.md)
* [26/04/17 New Option: WebP conversion support](examples/examples-webp-260417.md)
* [26/04/17 New Option: WebP conversion + Compare Mode](examples/examples-webp-compare-260417.md)
* [27/04/17 New Option: ImageMagick 7 Custom Install](examples/imagemagick7-install.md)
* [27/04/17 New Option: Benchmark Mode](examples/benchmark-mode.md)
* [27/04/17 New Option: Benchmark WebP + Compare Mode](examples/benchmark-mode-webp-compare.md)
* [28/04/17 New Option: Profile Log Only Option](examples/profile-logonly.md)
* [29/04/17 Benchmark Compare - All JPG/PNG Compressors](examples/benchmark-mode-compare-compressors1.md)
* [30/04/17 New Option: optimise-webp mode](/examples/examples-optimise-webp-300417.md)
* [30/04/17 New Option: optimise-webp-nginx mode (updated 01/05/17 static gallery added)](/examples/examples-optimise-webp-nginx-300417.md)
* [17/08/17 New Option: profile-age & optimise-age Mode](examples/age-170817.md)
* [17/08/17 New Option: optimise-cron & optimise-cron-age Mode](examples/cron-170817.md)
* [18/08/17 New Option: ADD_COMMENT variable marker to skip previously optimised images](examples/skip-optimised-images-180817.md)

Example Optimisation
===============

Example below uses preset selection of images localed in directory `/home/nginx/domains/domain.com/public/images`

Create directory

    mkdir -p /home/nginx/domains/domain.com/public/images

Setup `optimise-images.sh`

    mkdir -p /root/tools
    cd /root/tools
    git clone --depth=1 https://github.com/centminmod/optimise-images

Usage Options

    ./optimise-images.sh 
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-age} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-cron} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-cron-age} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-webp} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-webp-nginx} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile-age} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profilelog} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {install}
    ./optimise-images.sh {bench}
    ./optimise-images.sh {bench-compare}
    ./optimise-images.sh {bench-webp}
    ./optimise-images.sh {bench-webpcompare}
    ./optimise-images.sh {bench} all
    ./optimise-images.sh {bench-compare} all
    ./optimise-images.sh {bench-webp} all
    ./optimise-images.sh {bench-webpcompare} all

Google Guetzli Notes

* Guetzli uses a large amount of memory. You should provide 300MB of memory per 1MPix of the input image.
* Guetzli uses a significant amount of CPU time. You should count on using about 1 minute of CPU per 1 MPix of input image.
* When enabled with `GUETZLI='y'` and `TESTFILES_MINIMAL='n'` some of the additional sample jpg images are unable to optimise resulting in the following errors as it seems Guetzli is designed to work on high quality image sources which haven't already been compressed i.e. lossless format source images such as PNG [https://github.com/google/guetzli/issues/195](https://github.com/google/guetzli/issues/195):

```
Unsupported input JPEG file (e.g. unsupported downsampling mode).
Please provide the input image as a PNG file.
```

Variables by default 

* sample image downloads are kept minimal with `TESTFILES_MINIMAL='y'`. Large sample set of images to test against are available when set `TESTFILES_MINIMAL='n'`
* use ImageMagick convert to resize to max resolution `MAXRES='2048'` 
* with JPG image optimisation with JpegOptim with quality of `IMAGICK_QUALITY='82'` for jpeg/jpg when `JPEGOPTIM='y'` set
* with PNG use OPTIPNG quality of `92` meaning `png:compression-level=9` and `png:compression-strategy=2` by default when `OPTIPNG='y'` set.
* strip meta-data from images via `STRIP='y'`


```
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
```

Populate via `testfiles` command option passing the directory `/home/nginx/domains/domain.com/public/images` with sample images on the command line

    /root/tools/optimise-images/optimise-images.sh testfiles /home/nginx/domains/domain.com/public/images

Output

    Downloading sample image files
    to /home/nginx/domains/domain.com/public/images
    2017-04-27 16:18:46 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/samsung_s7_mobile_1.jpg [2100858/2100858] -> "samsung_s7_mobile_1.jpg" [1]
    2017-04-27 16:18:47 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_1.jpg [207430/207430] -> "dslr_canon_eos_m6_1.jpg" [1]
    2017-04-27 16:18:48 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/webp-study-source-firebreathing.png [1206455/1206455] -> "webp-study-source-firebreathing.png" [1]
    2017-04-27 16:18:48 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-image1.png [400998/400998] -> "png24-image1.png" [1]
    2017-04-27 16:18:49 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-interlaced-image1.png [456949/456949] -> "png24-interlaced-image1.png" [1]
    
    total 4.3M
    drwxr-sr-x  2 root  nginx 4.0K Apr 27 16:18 .
    drwxr-s---. 4 nginx nginx 4.0K Apr 23 06:35 ..
    -rw-r--r--  1 root  nginx 203K Apr 27 16:18 dslr_canon_eos_m6_1.jpg
    -rw-r--r--  1 root  nginx 392K Apr 27 16:18 png24-image1.png
    -rw-r--r--  1 root  nginx 447K Apr 27 16:18 png24-interlaced-image1.png
    -rw-r--r--  1 root  nginx 2.1M Apr 27 16:18 samsung_s7_mobile_1.jpg
    -rw-r--r--  1 root  nginx 1.2M Apr 27 16:18 webp-study-source-firebreathing.png

Profile original images via script's `profile` flag and pass the directory path to the directory containing the images you want to optimise `/home/nginx/domains/domain.com/public/images`. This is your baseline to compare resizing and optimisations applied to images using above default variable parameters.

Original images average 1491 pixel width, 1075 pixel height, 92% image quality and 874,438 bytes per image with total size of 4,270 KB.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-270417-161941.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1491      | 1075       | 92          | 874538     | 4372690            | 4270            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-4 Q16 x86_64 2017-04-25
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 0.14 seconds
    ------------------------------------------------------------------------------

Optimise images using `optimise` flag and pass the directory path to the directory containing the images you want to optimise `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh optimise /home/nginx/domains/domain.com/public/images

Then use `profile` flag again to profile the optimised images.

Optimised images average 1094 pixel width, 778 pixel height, 88% image quality and 476,711 bytes per image with total size of 2328 KB.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images 
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-270417-162213.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1094      | 778        | 88          | 476711     | 2383556            | 2328            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-4 Q16 x86_64 2017-04-25
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 0.08 seconds
    ------------------------------------------------------------------------------

Side by side comparison of original vs default resized/optimised image profiles using generated log files during profile runs. Originals (left) vs resized/optimised (right)

    sdiff -w 180 /home/optimise-logs/profile-log-270417-161941.log /home/optimise-logs/profile-log-270417-162213.log
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx | image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx         | image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : ng | image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : ng
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : ngi | image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : ngin
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : | image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 :

Use optional ZopfliPNG instead of OptiPNG for png file optimisations

```
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'

# additional image optimisations after imagemagick
# resizing
JPEGOPTIM='y'
GUETZLI='n'
# choose either OPTIPNG or ZOPFLIPNG
OPTIPNG='n'
ZOPFLIPNG='y'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'
```

Resulting optimised image profiles

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-270417-162455.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1184812 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1094      | 778        | 88          | 474908     | 2374541            | 2319            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-4 Q16 x86_64 2017-04-25
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 0.08 seconds
    ------------------------------------------------------------------------------

Focus on png file optimisations for select files not much difference.

For OptiPNG - averages 1224 width, 1022 height, 92 quality, 268,831 KB per image

    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : nginx

    | 741       | 517        | 92          | 655406     | 1966217            | 1920            |

For ZopfliPNg - averages 1224 width, 1022 height, 92 quality, 256,931 KB per image (~4.4% smaller than OptiPNG)

    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1184812 : root : nginx

    | 741       | 517        | 92          | 652401     | 1957202            | 1911            |

Disabling JpegOptim, OptiPNG and ZopfliPNG and just rely on ImageMagick convert to resize images.

```
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'

# additional image optimisations after imagemagick
# resizing
JPEGOPTIM='n'
GUETZLI='n'
# choose either OPTIPNG or ZOPFLIPNG
OPTIPNG='n'
ZOPFLIPNG='n'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'
```

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images                                                         
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-270417-163119.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 159911 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 273460 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1200202 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1094      | 778        | 88          | 481193     | 2405963            | 2350            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-4 Q16 x86_64 2017-04-25
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 0.08 seconds
    ------------------------------------------------------------------------------

Switching from JpegOptim to Google Guetzli compressor just for .jpg image optimisations (not .png)

    # additional image optimisations after imagemagick
    # resizing
    JPEGOPTIM='n'
    GUETZLI='y'
    # choose either OPTIPNG or ZOPFLIPNG
    OPTIPNG='y'
    ZOPFLIPNG='n'

Guetzli .jpg optimised profile

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-270417-163538.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 116224 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 273460 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1094      | 778        | 88          | 471180     | 2355901            | 2301            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-4 Q16 x86_64 2017-04-25
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 0.08 seconds
    ------------------------------------------------------------------------------

###### Summary

| Image State | Avg Width | Avg Height | Avg Quality | Avg Size (bytes) | Total Size (KB) | Reduction |
| --- | --- | --- | --- | --- | --- | --- | 
| Original Images | 1491      | 1075       | 92          | 874538     |4270            | |
| Optimised Default JpegOptim/OptiPNG | 1094      | 778        | 88          | 476711      | 2328            | -45.48% |
| Optimised JpegOptim/ZopfliPNG | 1094      | 778        | 88          | 474908      | 2319            | -45.69% |
| Optimised Guetzli//OptiPNG | 1094      | 778        | 88          | 471180     | 2301            | -46.11% |
| ImageMagick resize only disable JpegOptim/OptiPNG | 1094      | 778        | 88          | 481193     | 2350            | -44.96% |

Unattended Subdirectory Runs
===============

`optimise-images.sh` only operates on the directory max depth = 1 so only images within the directory you point to are profiled and optimised. Subdirectories under the directory you point to are not processed. You can easily script this yourself using a while read loop or for loop. 

An example for `/home/testsubdir` has 4 subdirectories called `subdir1`, `subdir2`, `subdir3`, `subdir4`. For demo purposes each subdirectory has one image `bees.png`

    ls -lah /home/testsubdir/
    total 24K
    drwxr-xr-x   6 root root 4.0K May  3 16:37 .
    drwxr-xr-x. 11 root root 4.0K May  3 16:32 ..
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir1
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir2
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir3
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdri4

recursive listing

    ls -lahR /home/testsubdir/
    /home/testsubdir/:
    total 24K
    drwxr-xr-x   6 root root 4.0K May  3 16:37 .
    drwxr-xr-x. 11 root root 4.0K May  3 16:32 ..
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir1
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir2
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdir3
    drwxr-xr-x   2 root root 4.0K May  3 16:35 subdri4
    
    /home/testsubdir/subdir1:
    total 180K
    drwxr-xr-x 2 root root 4.0K May  3 16:35 .
    drwxr-xr-x 6 root root 4.0K May  3 16:37 ..
    -rw-r--r-- 1 root root 172K May  3 16:35 bees.png
    
    /home/testsubdir/subdir2:
    total 180K
    drwxr-xr-x 2 root root 4.0K May  3 16:35 .
    drwxr-xr-x 6 root root 4.0K May  3 16:37 ..
    -rw-r--r-- 1 root root 172K May  3 16:35 bees.png
    
    /home/testsubdir/subdir3:
    total 180K
    drwxr-xr-x 2 root root 4.0K May  3 16:35 .
    drwxr-xr-x 6 root root 4.0K May  3 16:37 ..
    -rw-r--r-- 1 root root 172K May  3 16:35 bees.png
    
    /home/testsubdir/subdri4:
    total 180K
    drwxr-xr-x 2 root root 4.0K May  3 16:35 .
    drwxr-xr-x 6 root root 4.0K May  3 16:37 ..
    -rw-r--r-- 1 root root 172K May  3 16:35 bees.png

sample while read that just echo prints subdirectory name using find directory types under /home/testsubdir and pipe subdirectory list to while read loop making directory name a variable = d

    find /home/testsubdir/ -mindepth 1 -type d | sort | while read d; do echo "directory: $d"; done

outputs

    find /home/testsubdir/ -mindepth 1 -type d | sort | while read d; do echo "directory: $d"; done
    directory: /home/testsubdir/subdir1
    directory: /home/testsubdir/subdir2
    directory: /home/testsubdir/subdir3
    directory: /home/testsubdir/subdri4

if you want to include parent directory /home/testsubdir remove the -mindepth 1 from find command

    find /home/testsubdir/ type d | sort | while read d; do echo "directory: $d"; done 
    directory: /home/testsubdir/
    directory: /home/testsubdir/subdir2
    directory: /home/testsubdir/subdir3
    directory: /home/testsubdir/subdir1
    directory: /home/testsubdir/subdri4

modify for optimise-images.sh command

to `profile` images

    find /home/testsubdir/ -type d | sort | while read d; do echo "profile directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh profile $d"; /root/tools/optimise-images/optimise-images.sh profile $d; done

to `optimise` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh optimise $d"; /root/tools/optimise-images/optimise-images.sh optimise $d; done

or use new `optimise-cron` mode specifically made for use as a cronjob as it saves processing time by removing the post-optimisation profile run. Set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-cron` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh optimise-cron $d"; /root/tools/optimise-images/optimise-images.sh optimise-cron $d; done

or use new `optimise-cron-age` mode to filter by [image timestamp age](examples/age-170817.md) + specifically made for use as a cronjob as it saves processing time by removing the post-optimisation profile run. Set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-cron-age` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh optimise-cron-age $d"; /root/tools/optimise-images/optimise-images.sh optimise-cron-age $d; done

or to `optimise-webp` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-webp` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise-webp directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh optimise-webp $d"; /root/tools/optimise-images/optimise-images.sh optimise-webp $d; done

or to `optimise-webp-nginx` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-webp-nginx` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise-webp-nginx directory: $d"; echo "/root/tools/optimise-images/optimise-images.sh optimise-webp-nginx $d"; /root/tools/optimise-images/optimise-images.sh optimise-webp-nginx $d; done

This will 

* find any subdirectories within `/home/testsubdir` and sort them through a while read loop assigning the subdirectories found to variable `d`. 
* so first directory found `/home/testsubdir/` will be assigned to variable `d=/home/testsubdir/` 
* then echo directory name assigned to variable `d` 
* then echo the command you will run
* then finally run the actual command on the directory assigned to variable `d`
* the while read loop will repeat the previous cycle of steps for next directory found `/home/testsubdir/subdir2` and so forth until all subdirectories found are looped through.

A more recent example of batch image optimisation for Wordpress uploaded images can be found [here](https://community.centminmod.com/posts/65241/).

Dockerfile
===============

Dockerfile support is experimental so no guarantee that it works. Contributions by more Docker users in making it work are welcomed via git pull requests.

## Building the Docker Image From Dockerfile

There are 2 ways to build the optimise-images.sh Docker image:

1. Manual docker build
2. Via dockerbuild.sh

### Manual docker build

```
mkdir -p /root/tools
cd /root/tools
git clone --depth=1 https://github.com/centminmod/optimise-images
cd /root/tools/optimage-images
docker build --tag optimise-images:1.0 .
```

### Via dockerbuild.sh

```
mkdir -p /root/tools
cd /root/tools
git clone --depth=1 https://github.com/centminmod/optimise-images
cd /root/tools/optimage-images
./dockerbuild.sh build
```

dockerbuild.sh also has a test feature which runs `optimise-images.sh bench-webpcompare` benchmark mode which compares a test set of JPG & PNG images against both optimised JPG, PNG and webP format versions.

```
cd /root/tools/optimage-images
./dockerbuild.sh test
```

`dockerbuild.sh test` resulting comparison output for preset test images which results in original image vs .webP vs `_optimal` suffix optimised/resized version.

```
------------------------------------------------------------------------------
image profile 
image name : width : height : quality : transparency : image depth (bits) : size : user: group
------------------------------------------------------------------------------
images in /home/optimise-benchmarks
logged at /home/optimise-logs/profile-log-090420-002424.log
------------------------------------------------------------------------------
image : bees.png : 444 : 258 : 92 : False : 8 : 177424 : root : root
image : bees.png.webp : 444 : 258 : 92 : False : 8 : 11226 : root : root
image : bees_optimal.png : 444 : 258 : 92 : False : 8 : 175256 : root : root
image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root
image : dslr_canon_eos_m6_1.jpg.webp : 1200 : 800 : 92 : False : 8 : 66220 : root : root
image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 89 : False : 8 : 192255 : root : root
image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root
image : dslr_nikon_d7200_1.jpg.webp : 2048 : 1365 : 92 : False : 8 : 192268 : root : root
image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 89 : False : 8 : 511249 : root : root
image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root
image : dslr_nikon_d7200_2.jpg.webp : 1365 : 2048 : 92 : False : 8 : 231510 : root : root
image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 89 : False : 8 : 605214 : root : root
image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
image : png24-image1.png.webp : 600 : 400 : 92 : False : 8 : 29324 : root : root
image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
image : png24-interlaced-image1.png.webp : 600 : 400 : 92 : False : 8 : 29324 : root : root
image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 443931 : root : root
image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root
image : samsung_s7_mobile_1.jpg.webp : 2048 : 1536 : 92 : False : 8 : 78396 : root : root
image : samsung_s7_mobile_1_optimal.jpg : 2048 : 1536 : 89 : False : 8 : 375607 : root : root
image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
image : webp-study-source-firebreathing.png.webp : 1024 : 752 : 92 : False : 8 : 78652 : root : root
image : webp-study-source-firebreathing_optimal.png : 1024 : 752 : 92 : False : 8 : 1194070 : root : root

------------------------------------------------------------------------------
Original or Existing Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 2238      | 1954       | 92          | 2406978    | 19255825           | 18805           |

------------------------------------------------------------------------------
Optimised Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 1166      | 945        | 90          | 485456     | 3883645            | 3793            |

------------------------------------------------------------------------------
Optimised WebP Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 1166      | 945        | 92          | 89615      | 716920             | 700             |
```

### Resulting Docker images

```
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
optimise-images     1.0                 f338939fb838        30 seconds ago      574MB
centos              7                   5e35e350aded        4 months ago        203MB
```
```
docker run --rm -it optimise-images:1.0 optimise-images.sh

Usage:

/root/tools/optimise-images/optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {optimise-age} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {optimise-cron} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {optimise-cron-age} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {optimise-webp} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {optimise-webp-nginx} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {profile-age} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {profilelog} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES
/root/tools/optimise-images/optimise-images.sh {install}
/root/tools/optimise-images/optimise-images.sh {bench}
/root/tools/optimise-images/optimise-images.sh {bench-compare}
/root/tools/optimise-images/optimise-images.sh {bench-webp}
/root/tools/optimise-images/optimise-images.sh {bench-webpcompare}
/root/tools/optimise-images/optimise-images.sh {bench} all
/root/tools/optimise-images/optimise-images.sh {bench-compare} all
/root/tools/optimise-images/optimise-images.sh {bench-webp} all
/root/tools/optimise-images/optimise-images.sh {bench-webpcompare} all
```

Would need to use docker volume to map system directory to docker container image directory if using optimise-images.sh within a docker container.

So for `/home/optimise-benchmarks` system directory full of images to profile it, you would run:

```
docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:1.0 optimise-images.sh profile /home/optimise-benchmarks
```

To optimise the directory

```
docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:1.0 optimise-images.sh optimise /home/optimise-benchmarks
```

Profile mode run:

```
docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:1.0 optimise-images.sh profile /home/optimise-benchmarks

------------------------------------------------------------------------------
image profile 
image name : width : height : quality : transparency : image depth (bits) : size : user: group
------------------------------------------------------------------------------
images in /home/optimise-benchmarks
logged at /home/optimise-logs/profile-log-050420-015006.log
------------------------------------------------------------------------------
image : bees.png : 444 : 258 : 92 : False : 8 : 175256 : root : root
image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161442 : root : root
image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 377126 : root : root
image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 520565 : root : root
image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 443931 : root : root
image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 259901 : root : root
image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194070 : root : root

------------------------------------------------------------------------------
Original or Existing Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 1166      | 945        | 87          | 439794     | 3518354            | 3436            |

------------------------------------------------------------------------------
ImageMagick Resource Limits
------------------------------------------------------------------------------
Version: ImageMagick 6.9.11-3 Q16 x86_64 2020-03-30
Resource limits:
  Width: 214.7MP
  Height: 214.7MP
  List length: unlimited
  Area: 3.8543GP
  Memory: 1.79481GiB
  Map: 3.58962GiB
  Disk: unlimited
  File: 786432
  Thread: 2
  Throttle: 0
  Time: unlimited
------------------------------------------------------------------------------
Completion Time: 0.58 seconds
------------------------------------------------------------------------------
```

Optimise mode run:

```
docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:1.0 optimise-images.sh optimise /home/optimise-benchmarks

!!! Important !!!

Have you made a backup of images in /home/optimise-benchmarks? [y/n]: y

------------------------------------------------------------------------------
image optimisation start
------------------------------------------------------------------------------
### samsung_s7_mobile_1.jpg (jpg) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp samsung_s7_mobile_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> samsung_s7_mobile_1.jpg
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 samsung_s7_mobile_1.jpg
samsung_s7_mobile_1.jpg 2048x1536 24bit N JFIF  [OK] 260188 --> 260142 bytes (0.02%), optimized.
### dslr_canon_eos_m6_1.jpg (jpg) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_canon_eos_m6_1.jpg
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_canon_eos_m6_1.jpg
dslr_canon_eos_m6_1.jpg 1200x800 24bit N JFIF  [OK] 161453 --> 161388 bytes (0.04%), optimized.
### dslr_nikon_d7200_1.jpg (jpg) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_nikon_d7200_1.jpg
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_nikon_d7200_1.jpg
dslr_nikon_d7200_1.jpg 2048x1365 24bit N JFIF  [OK] 376994 --> 376881 bytes (0.03%), optimized.
### dslr_nikon_d7200_2.jpg (jpg) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_2.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_nikon_d7200_2.jpg
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_nikon_d7200_2.jpg
dslr_nikon_d7200_2.jpg 1365x2048 24bit N JFIF  [OK] 520648 --> 520648 bytes (0.00%), skipped.
### bees.png (png) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp bees.png -interlace none -set comment optimised -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> bees.png
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 bees.png -preserve -out bees.png
Output IDAT size = 175199 bytes (no change)
Output file size = 175480 bytes (60 bytes = 0.03% decrease)
### webp-study-source-firebreathing.png (png) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-firebreathing.png -interlace none -set comment optimised -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> webp-study-source-firebreathing.png
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 webp-study-source-firebreathing.png -preserve -out webp-study-source-firebreathing.png
Output IDAT size = 1194013 bytes (5679 bytes decrease)
Output file size = 1194294 bytes (6111 bytes = 0.51% decrease)
### png24-image1.png (png) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-image1.png -interlace none -set comment optimised -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> png24-image1.png
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 png24-image1.png -preserve -out png24-image1.png
Output IDAT size = 386006 bytes (no change)
Output file size = 386287 bytes (132 bytes = 0.03% decrease)
### png24-interlaced-image1.png (png) ###
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-interlaced-image1.png -interlace plane -set comment optimised -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> png24-interlaced-image1.png
/bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 png24-interlaced-image1.png -preserve -out png24-interlaced-image1.png
Output IDAT size = 443874 bytes (2304 bytes decrease)
Output file size = 444155 bytes (2460 bytes = 0.55% decrease)
------------------------------------------------------------------------------
Completion Time: 22.58 seconds
------------------------------------------------------------------------------

------------------------------------------------------------------------------
image profile 
image name : width : height : quality : transparency : image depth (bits) : size : user: group
------------------------------------------------------------------------------
images in /home/optimise-benchmarks
logged at /home/optimise-logs/profile-log-050420-020515.log
------------------------------------------------------------------------------
image : bees.png : 444 : 258 : 92 : False : 8 : 175480 : root : root
image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161388 : root : root
image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 376881 : root : root
image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 520648 : root : root
image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386287 : root : root
image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 444155 : root : root
image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 260142 : root : root
image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194294 : root : root

------------------------------------------------------------------------------
Original or Existing Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 1166      | 945        | 87          | 439909     | 3519275            | 3437            |

------------------------------------------------------------------------------
ImageMagick Resource Limits
------------------------------------------------------------------------------
Version: ImageMagick 6.9.11-3 Q16 x86_64 2020-03-30
Resource limits:
  Width: 214.7MP
  Height: 214.7MP
  List length: unlimited
  Area: 3.8543GP
  Memory: 1.79481GiB
  Map: 3.58962GiB
  Disk: unlimited
  File: 786432
  Thread: 2
  Throttle: 0
  Time: unlimited
------------------------------------------------------------------------------
Completion Time: 0.59 seconds
------------------------------------------------------------------------------
```

`ADD_COMMENT='y'` is now enabled by default to skip already optimised images which are tagged with comment `optimised' so on subsequent re-runs:

```
docker run --rm -it -v /home/optimise-benchmarks:/home/optimise-benchmarks optimise-images:1.0 optimise-images.sh optimise /home/optimise-benchmarks

!!! Important !!!

Have you made a backup of images in /home/optimise-benchmarks? [y/n]: y

------------------------------------------------------------------------------
image optimisation start
------------------------------------------------------------------------------
### samsung_s7_mobile_1.jpg (jpg) skip already optimised ###
### dslr_canon_eos_m6_1.jpg (jpg) skip already optimised ###
### dslr_nikon_d7200_1.jpg (jpg) skip already optimised ###
### dslr_nikon_d7200_2.jpg (jpg) skip already optimised ###
### bees.png (png) skip already optimised ###
### webp-study-source-firebreathing.png (png) skip already optimised ###
### png24-image1.png (png) skip already optimised ###
### png24-interlaced-image1.png (png) skip already optimised ###
------------------------------------------------------------------------------
Completion Time: 5.73 seconds
------------------------------------------------------------------------------

------------------------------------------------------------------------------
image profile 
image name : width : height : quality : transparency : image depth (bits) : size : user: group
------------------------------------------------------------------------------
images in /home/optimise-benchmarks
logged at /home/optimise-logs/profile-log-050420-020634.log
------------------------------------------------------------------------------
image : bees.png : 444 : 258 : 92 : False : 8 : 175480 : root : root
image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161388 : root : root
image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 376881 : root : root
image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 520648 : root : root
image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386287 : root : root
image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 444155 : root : root
image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 260142 : root : root
image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194294 : root : root

------------------------------------------------------------------------------
Original or Existing Images:
------------------------------------------------------------------------------
| Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| 1166      | 945        | 87          | 439909     | 3519275            | 3437            |

------------------------------------------------------------------------------
ImageMagick Resource Limits
------------------------------------------------------------------------------
Version: ImageMagick 6.9.11-3 Q16 x86_64 2020-03-30
Resource limits:
  Width: 214.7MP
  Height: 214.7MP
  List length: unlimited
  Area: 3.8543GP
  Memory: 1.79481GiB
  Map: 3.58962GiB
  Disk: unlimited
  File: 786432
  Thread: 2
  Throttle: 0
  Time: unlimited
------------------------------------------------------------------------------
Completion Time: 0.61 seconds
------------------------------------------------------------------------------
````