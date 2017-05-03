optimise-images.sh
======

Batch jpg, jpeg and png image resizer, optimiser and image profiler using [ImageMagick](https://www.imagemagick.org/script/index.php) convert, [OptiPNG](http://optipng.sourceforge.net/), [JpegOptim](https://github.com/tjko/jpegoptim) and optional [Mozilla MozJPEG](https://github.com/mozilla/mozjpeg), [ZopfliPNG](https://github.com/google/zopfli) and [Google Guetzli](https://github.com/google/guetzli) (work in progress for Guetzli).

* [Features](#features)
* [Requirements](#requirements)
* [Other Examples](#other-examples)
* [Example Optimisation](#example-optimisation)
* [Unattended Subdirectory Runs](#unattended-subdirectory-runs)

Features
===============

* Profiler mode allows you to point the script to a directory of images and for JPG, JPEG and PNG files will profile and gather individual image's information such as image name, width, height, size, colour depth, whether it's a transparent image, image user/group permissions etc. Optionally, you can set `PROFILE_EXTEND='y'` to also display each individual images transparent and background colours. For processing speed, these are disabled by default with `PROFILE_EXTEND='y'`.
* The profiler runs are logged to directory defined by `LOGDIR='/home/optimise-logs'` so you can use command line tools like grep, awk etc to filter information or diff comparison tools to compare before and after optimisation profile logs. This allows you to double check the optimised and resized images retain their properties you require like image transparency or whether or not image is interlaced/progressive.
* Optimisation modes highlighted in examples linked below allow you to batch resize and optimise images as well as convert them to WebP format via tools such as ImageMagick, JpegOptim, OptiPNG and optionally support Mozilla MozJPEG, Google ZopfliPNG and Google Guetzli. Support for GraphicsMagick is still a work in progress though so is not fully supported for all  modes of operation.
* By default the resize and optimisation routines will check to see if an original image is transparent and/or is interlaced/progressive and will retain those image properties through the process.
* There are specific [optimisation modes](/examples/examples-optimise-webp-nginx-300417.md) which allow for more convenient conversions to WebP format - including automatic generation of a lazy load supported static html gallery displaying side by side, the optimised original versus the WebP converted image as well as [Ngnx syntax for WebP conditional serving](https://centminmod.com/webp/). You can turn off static html gallery generation via option `GALLERY_WEBP='n'`.
* Each optimise run will prompt user to ask if they have backed up their image directory prior to batch optimisation and resizing and is now controlled via variable `UNATTENDED_OPTIMISE='n'` which is set to default. You can skip the backup question prompt for more advanced scripted runs of `optimise-images.sh` by setting variable `UNATTENDED_OPTIMISE='y'`.
* Benchmark modes highlighted in example links below, allow more automation in doing the before optimisation profiling + optimisation + after optimisation profiling on a directory of images.
* Running the script is timed so you get timed completion statistics information so you can measure the speed of profiling, optimisation and conversion.
* System resource usage logging is done via sysstat after each individual image processing so you can use sar command to understand the cpu, memory and disk usage profiles during or after the script runs.
* You can control nice and ionice priorities for the conversion and resize processes via variables `NICEOPT='-n 10'` and `IONICEOPT='-c2 -n7'` to either set a higher or lower priority.

Requirements
===============

* ImageMagick 6+ or 7+
* CentOS Epel YUM repository
* CentOS/RHEL YUM install for `optipng` & `jpegoptim` 
* [Google Butteraugli](https://github.com/google/butteraugli) source installed automatically by `optimise-images.sh`
* `optimise-images.sh` will auto install via source compile if MozJPEG, `zopflipng` and/or `guetzli` is required

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
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {install}
    ./optimise-images.sh {bench}
    ./optimise-images.sh {bench-compare}
    ./optimise-images.sh {bench-webp}
    ./optimise-images.sh {bench-webpcompare}

Google Guetzli Notes

* Guetzli uses a large amount of memory. You should provide 300MB of memory per 1MPix of the input image.
* Guetzli uses a significant amount of CPU time. You should count on using about 1 minute of CPU per 1 MPix of input image.
* When enabled with `GUETZLI='y'` and `TESTFILES_MINIMAL='n'` some of the additional sample jpg images are unable to optimise resulting in the following errors as it seems Guetzli is designed wto work on high quality image sources which haven't already been compressed i.e. lossless format source images such as PNG [https://github.com/google/guetzli/issues/195](https://github.com/google/guetzli/issues/195):

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

    find /home/testsubdir/ -type d | sort | while read d; do echo "profile directory: $d"; echo "/root/tools/optimise-images.sh profile $d"; /root/tools/optimise-images.sh profile $d; done

to `optimise` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise directory: $d"; echo "/root/tools/optimise-images.sh optimise $d"; /root/tools/optimise-images.sh optimise $d; done

to `optimise-webp` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-webp` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise-webp directory: $d"; echo "/root/tools/optimise-images.sh optimise-webp $d"; /root/tools/optimise-images.sh optimise-webp $d; done

to `optimise-webp-nginx` images you need to first edit optimise-images.sh as per https://github.com/centminmod/optimise-images and set UNATTENDED_OPTIMISE='y' to disable the backup directory prompt so you can run unattended first. Edit `optimise-webp-nginx` command for command you want to use.

    find /home/testsubdir/ -type d | sort | while read d; do echo "optimise-webp-nginx directory: $d"; echo "/root/tools/optimise-images.sh optimise-webp-nginx $d"; /root/tools/optimise-images.sh optimise-webp-nginx $d; done

This will 

* find any subdirectories within `/home/testsubdir` and sort them through a while read loop assigning the subdirectories found to variable `d`. 
* so first directory found `/home/testsubdir/` will be assigned to variable `d=/home/testsubdir/` 
* then echo directory name assigned to variable `d` 
* then echo the command you will run
* then finally run the actual command on the directory assigned to variable `d`
* the while read loop will repeat the previous cycle of steps for next directory found `/home/testsubdir/subdir2` and so forth until all subdirectories found are looped through.