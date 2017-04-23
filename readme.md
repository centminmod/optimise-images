optimise-images.sh
======

Batch jpg, jpeg and png image resizer and optimiser using ImageMagick convert, OptiPNG, JpegOptim and optional ZopfliPNG.

###### Example


Example below uses preset selection of images localed in directory `/home/nginx/domains/domain.com/public/images`

Create directory

    mkdir -p /home/nginx/domains/domain.com/public/images

Setup `optimise-images.sh`

    mkdir -p /root/tools
    cd /root/tools
    git clone https://github.com/centminmod/optimise-images

Usage Options

    ./optimise-images.sh 
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES

Variables by default 

* use ImageMagick convert to resize to max resolution `MAXRES='2048'` 
* with image optimisation with JpegOptim with quality of `IMAGICK_QUALITY='82'` for jpeg/jpg 
* with PNG use OPTIPNG quality of `92` meaning `png:compression-level=9` and `png:compression-strategy=2`` by default.
* strip meta-data from images via `STRIP='y'`

```
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'
OPTIPNG='y'
JPEGOPTIM='y'
ZOPFLIPNG='n'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'
```

Populate directory `/home/nginx/domains/domain.com/public/images` with sample images

    /root/tools/optimise-images/optimise-images.sh testfiles /home/nginx/domains/domain.com/public/images

Images

    ls -lah /home/nginx/domains/domain.com/public/images
    total 29M
    drwxr-sr-x  2 root  nginx 4.0K Apr 23 18:36 .
    drwxr-s---. 4 nginx nginx 4.0K Apr 23 06:35 ..
    -rw-r--r--  1 root  nginx 203K Apr 23 18:36 dslr_canon_eos_m6_1.jpg
    -rw-r--r--  1 root  nginx  12M Mar 28 10:11 dslr_canon_eos_m6_large1.jpg
    -rw-r--r--  1 root  nginx 9.7M Mar 28 10:03 dslr_canon_eos_m6_large2.jpg
    -rw-r--r--  1 root  nginx 1.4M Apr 23 18:36 image1.jpg
    -rw-r--r--  1 root  nginx 943K Apr 23 18:36 image2.jpg
    -rw-r--r--  1 root  nginx 623K Apr 23 18:36 image3.jpg
    -rw-r--r--  1 root  nginx 690K Apr 23 18:36 image4.jpg
    -rw-r--r--  1 root  nginx 690K Apr 23 18:36 im age5.jpg
    -rw-r--r--  1 root  nginx  95K Apr 23 18:36 image6.jpg
    -rw-r--r--  1 root  nginx 223K Apr 23 18:36 image7.jpg
    -rw-r--r--  1 root  nginx 338K Apr 23 18:36 mobile1.jpg
    -rw-r--r--  1 root  nginx 216K Apr 23 18:36 mobile2.jpg
    -rw-r--r--  1 root  nginx 262K Apr 23 18:36 mobile3.jpg
    -rw-r--r--  1 root  nginx 392K Apr 23 18:36 png24-image1.png
    -rw-r--r--  1 root  nginx 447K Apr 23 18:36 png24-interlaced-image1.png
    -rw-r--r--  1 root  nginx 206K Apr 23 18:36 pngimage1.png
    -rw-r--r--  1 root  nginx  40K Apr 23 18:36 pngimage2.png
    -rw-r--r--  1 root  nginx 438K Apr 23 18:36 pngimage3.png
    -rw-r--r--  1 root  nginx 446K Apr 23 18:36 pngimage4.png
    -rw-r--r--  1 root  nginx 149K Apr 23 18:36 screenshot1.png

Profile original images via script's `profile` flag and pass the directory path to the directory containing the images you want to optimise `/home/nginx/domains/domain.com/public/images`. This is your baseline to compare resizing and optimisations applied to images using above default variable parameters.

Original images average 1839 pixel width, 1304 pixel height, 93% image quality and 1,503,378 bytes per image with total size of 29,362.8 KB.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images. 

    -------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    -------------------------------------------------------------------------
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : nginx
    
    -------------------------------------------------------------------------
    average image width, height, image quality and size
    -------------------------------------------------------------------------
    1839 1304 93 1503378
    
    -------------------------------------------------------------------------
    Total Image Size: 30067550 Bytes 29362.8 KB
    -------------------------------------------------------------------------

Optimise images using `optimise` flag and pass the directory path to the directory containing the images you want to optimise `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh optimise /home/nginx/domains/domain.com/public/images

Then use `profile` flag again to profile the optimised images.

Optimised images average 1425 pixel width, 1017 pixel height, 86% image quality and 252,817 bytes per image with total size of 4,937.83 KB.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images 

    -------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    -------------------------------------------------------------------------
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : False : 8 : 304069 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : False : 8 : 402584 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image1.jpg : 2048 : 1290 : 82 : False : 8 : 418884 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image2.jpg : 2048 : 1248 : 82 : False : 8 : 282808 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image3.jpg : 1600 : 1048 : 82 : False : 8 : 271018 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image4.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/im age5.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image6.jpg : 640 : 427 : 82 : False : 8 : 71496 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image7.jpg : 600 : 400 : 82 : False : 8 : 48906 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile1.jpg : 1200 : 900 : 82 : False : 8 : 280918 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile2.jpg : 1200 : 900 : 82 : False : 8 : 177339 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile3.jpg : 1200 : 900 : 82 : False : 8 : 217147 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 454890 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : nginx
    
    -------------------------------------------------------------------------
    average image width, height, image quality and size
    -------------------------------------------------------------------------
    1425 1017 86 252817
    
    -------------------------------------------------------------------------
    Total Image Size: 5056339 Bytes 4937.83 KB
    -------------------------------------------------------------------------

Use optional ZopfliPNG instead of OptiPNG for png file optimisations

```
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'
OPTIPNG='n'
JPEGOPTIM='y'
ZOPFLIPNG='y'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'
```

Resulting optimised image profiles - average 1425 pixel width, 1017 pixel height, 86% image quality and 248,652 bytes per image with total size of 4,856.48 KB.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images  
    
    -------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    -------------------------------------------------------------------------
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : False : 8 : 304069 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : False : 8 : 402584 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image1.jpg : 2048 : 1290 : 82 : False : 8 : 418884 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image2.jpg : 2048 : 1248 : 82 : False : 8 : 282808 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image3.jpg : 1600 : 1048 : 82 : False : 8 : 271018 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image4.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/im age5.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image6.jpg : 640 : 427 : 82 : False : 8 : 71496 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image7.jpg : 600 : 400 : 82 : False : 8 : 48906 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile1.jpg : 1200 : 900 : 82 : False : 8 : 280918 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile2.jpg : 1200 : 900 : 82 : False : 8 : 177339 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile3.jpg : 1200 : 900 : 82 : False : 8 : 217147 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 1623 : 2048 : 92 : True : 8 : 239891 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 17149 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 268890 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 406256 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 93940 : root : nginx
    
    -------------------------------------------------------------------------
    average image width, height, image quality and size
    -------------------------------------------------------------------------
    1425 1017 86 248652
    
    -------------------------------------------------------------------------
    Total Image Size: 4973039 Bytes 4856.48 KB
    -------------------------------------------------------------------------

Focus on png file optimisations

For OptiPNG - averages 1224 width, 1022 height, 92 quality, 268,831 KB per image

    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 454890 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : nginx

For ZopfliPNg - averages 1224 width, 1022 height, 92 quality, 256,931 KB per image (~4.4% smaller than OptiPNG)

    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 1623 : 2048 : 92 : True : 8 : 239891 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 17149 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 268890 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 406256 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 93940 : root : nginx

Disabling JpegOptim, OptiPNG and ZopfliPNG and just rely on ImageMagick convert to resize images - average 1425 pixel width, 1017 pixel height, 86% image quality and 478,688 bytes per image with total size of 9,348.38 KB.

```
IMAGICK_RESIZE='y'
IMAGICK_QUALITY='82'
OPTIPNG='n'
JPEGOPTIM='n'
ZOPFLIPNG='n'

# max width and height
MAXRES='2048'

# strip meta-data
STRIP='y'
```

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    -------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    -------------------------------------------------------------------------
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 159911 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : False : 8 : 423082 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : False : 8 : 469109 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image1.jpg : 2048 : 1290 : 82 : False : 8 : 538658 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image2.jpg : 2048 : 1248 : 82 : False : 8 : 333522 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image3.jpg : 1600 : 1048 : 82 : False : 8 : 329107 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image4.jpg : 2048 : 1269 : 82 : False : 8 : 319133 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/im age5.jpg : 2048 : 1269 : 82 : False : 8 : 319133 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image6.jpg : 640 : 427 : 82 : False : 8 : 94883 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/image7.jpg : 600 : 400 : 82 : False : 8 : 60824 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile1.jpg : 1200 : 900 : 82 : False : 8 : 279998 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile2.jpg : 1200 : 900 : 82 : False : 8 : 176106 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/mobile3.jpg : 1200 : 900 : 82 : False : 8 : 216017 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386195 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage1.png : 1623 : 2048 : 92 : True : 8 : 1861498 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage2.png : 1700 : 1374 : 92 : True : 8 : 231910 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage3.png : 2000 : 1370 : 92 : True : 8 : 1720900 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/pngimage4.png : 558 : 465 : 92 : True : 8 : 506923 : root : nginx
    image : /home/nginx/domains/domain.com/public/images/screenshot1.png : 1484 : 1095 : 92 : False : 8 : 760657 : root : nginx
    
    -------------------------------------------------------------------------
    average image width, height, image quality and size
    -------------------------------------------------------------------------
    1425 1017 86 478688
    
    -------------------------------------------------------------------------
    Total Image Size: 9573761 Bytes 9349.38 KB
    -------------------------------------------------------------------------

###### Summary

| Image State | Avg Width | Avg Height | Avg Quality | Avg Size (bytes) | Total Size (KB) | Reduction |
| --- | --- | --- | --- | --- | --- | --- | 
| Original Images | 1839 | 1304 | 93 | 1503378 | 29362.80 | |
| Optimised Default JpegOptim/OptiPNG | 1425 | 1017 | 86 | 252817 | 4937.83 | -83.18% |
| Optimised JpegOptim/ZopfliPNG | 1425 | 1017 | 86 | 248652 | 4856.48 | -83.46% |
| ImageMagick resize only disable JpegOptim/OptiPNG | 1425 | 1017 | 86 | 478688 | 9349.38 | -68.16% |