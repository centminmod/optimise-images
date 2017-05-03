[optimise-images.sh](https://github.com/centminmod/optimise-images) added new `install` option to source install ImageMagick 7.x with Quantum Depth of 8 instead of 16 for speed.

ImageMagick 7 enables [high dynamic range imaging](https://www.imagemagick.org/script/high-dynamic-range.php) (HDRI) by default which requires more memory and results in slower processing times than ImagickMagick 6 ([source](https://www.imagemagick.org/script/porting.php)). The `optimise-images.sh` script will disable HDRI by default to match ImageMagick 6 processing times and memory usage via option `IMAGICK_SEVENHDRI='n'`. You can enable HDRI via `IMAGICK_SEVENHDRI='y'` and `IMAGICK_SEVEN='y'` and then running `optimise-images.sh install` command to reinstall ImageMagick 7.

Usage options:

    ./optimise-images.sh
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {install}

To install ImageMagick 7 on CentOS

    ./optimise-images.sh install

End up with binaries are custom locations i.e.

    /opt/imagemagick7/bin/identify
    /opt/imagemagick7/bin/convert

Check version

    /opt/imagemagick7/bin/identify --version
    Version: ImageMagick 7.0.5-5 Q8 x86_64 2017-04-26 http://www.imagemagick.org
    Copyright: © 1999-2017 ImageMagick Studio LLC
    License: http://www.imagemagick.org/script/license.php
    Features: Cipher DPC HDRI OpenMP 
    Delegates (built-in): bzlib fontconfig freetype jbig jng jpeg lcms lzma openexr png tiff webp x xml zlib

Full binary listing

    ls -lah /opt/imagemagick7/bin/
    total 36K
    drwxr-xr-x 2 root root 4.0K Apr 26 15:31 .
    drwxr-xr-x 7 root root 4.0K Apr 26 15:19 ..
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 animate -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 compare -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 composite -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 conjure -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 convert -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 display -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 identify -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 import -> magick
    -rwxr-xr-x 1 root root  14K Apr 26 15:31 magick
    -rwxr-xr-x 1 root root 1.3K Apr 26 15:31 Magick++-config
    -rwxr-xr-x 1 root root 1.5K Apr 26 15:31 MagickCore-config
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 magick-script -> magick
    -rwxr-xr-x 1 root root 1.3K Apr 26 15:31 MagickWand-config
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 mogrify -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 montage -> magick
    lrwxrwxrwx 1 root root    6 Apr 26 15:31 stream -> magick

Profile example after optimisation run when you set `IMAGICK_SEVEN='y'` to enable ImageMagick 7. If you set `IMAGICK_SEVEN='n`, you revert back to system installed ImageMagick version

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 2048 : 1365 : 82 : Undefined : 8 : 388237 : root : nginx
    image : dslr_canon_eos_77d_2.jpg : 2048 : 1365 : 82 : Undefined : 8 : 398208 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : Undefined : 8 : 161086 : root : nginx
    image : dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : Undefined : 8 : 304069 : root : nginx
    image : dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : Undefined : 8 : 402584 : root : nginx
    image : dslr_hasselblad_x1d_1.jpg : 2048 : 1535 : 82 : Undefined : 8 : 441979 : root : nginx
    image : dslr_hasselblad_x1d_2.jpg : 2048 : 1535 : 82 : Undefined : 8 : 369580 : root : nginx
    image : dslr_leica_m10_1.jpg : 2048 : 1365 : 82 : Undefined : 8 : 438656 : root : nginx
    image : dslr_leica_m10_2.jpg : 2048 : 1365 : 82 : Undefined : 8 : 438587 : root : nginx
    image : dslr_nikon_d5_1.jpg : 2048 : 1365 : 82 : Undefined : 8 : 287421 : root : nginx
    image : dslr_nikon_d5_2.jpg : 2048 : 1365 : 82 : Undefined : 8 : 310150 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : Undefined : 8 : 374954 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : Undefined : 8 : 516224 : root : nginx
    image : dslr_sony_alpha_a99_ii_1.jpg : 2048 : 1366 : 82 : Undefined : 8 : 349140 : root : nginx
    image : dslr_sony_alpha_a99_ii_2.jpg : 2048 : 1366 : 82 : Undefined : 8 : 431558 : root : nginx
    image : image1.jpg : 2048 : 1290 : 82 : Undefined : 8 : 418884 : root : nginx
    image : image2.jpg : 2048 : 1248 : 82 : Undefined : 8 : 282808 : root : nginx
    image : image3.jpg : 1600 : 1048 : 82 : Undefined : 8 : 271018 : root : nginx
    image : image4.jpg : 2048 : 1269 : 82 : Undefined : 8 : 269134 : root : nginx
    image : im age5.jpg : 2048 : 1269 : 82 : Undefined : 8 : 269134 : root : nginx
    image : image6.jpg : 640 : 427 : 82 : Undefined : 8 : 71496 : root : nginx
    image : image7.jpg : 600 : 400 : 82 : Undefined : 8 : 48906 : root : nginx
    image : lenna.png : 512 : 512 : 92 : Undefined : 8 : 474955 : root : nginx
    image : mobile1.jpg : 1200 : 900 : 82 : Undefined : 8 : 280918 : root : nginx
    image : mobile2.jpg : 1200 : 900 : 82 : Undefined : 8 : 177339 : root : nginx
    image : mobile3.jpg : 1200 : 900 : 82 : Undefined : 8 : 217147 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : Undefined : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : Undefined : 8 : 386063 : root : nginx
    image : pngimage1.png : 1623 : 2048 : 92 : Blend : 8 : 246604 : root : nginx
    image : pngimage2.png : 1700 : 1374 : 92 : Blend : 8 : 19228 : root : nginx
    image : pngimage3.png : 2000 : 1370 : 92 : Blend : 8 : 284292 : root : nginx
    image : pngimage4.png : 558 : 465 : 92 : Blend : 8 : 454890 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : Undefined : 8 : 256253 : root : nginx
    image : screenshot1.png : 1484 : 1095 : 92 : Undefined : 8 : 104676 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : Undefined : 8 : 1194091 : root : nginx
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : Blend : 8 : 107292 : root : nginx
    
    ------------------------------------------------------------------------------
    Original Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1583      | 1147       | 85          | 328712     | 11833624           | 11556           |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 7.0.5-5 Q8 x86_64 2017-04-26
    Resource limits:
    Width: 107.374MP
    Height: 107.374MP
    Area: 67.0574GP
    Memory: 31.226GiB
    Map: 62.4521GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 1.50 seconds
    ------------------------------------------------------------------------------