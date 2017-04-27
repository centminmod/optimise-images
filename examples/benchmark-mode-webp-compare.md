[optimise-images.sh](https://github.com/centminmod/optimise-images) added new benchmark mode option to test against preset sample images.

Usage options:

    ./optimise-images.sh 
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {testfiles} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {install}
    ./optimise-images.sh {bench}
    ./optimise-images.sh {bench-compare}
    ./optimise-images.sh {bench-webp}
    ./optimise-images.sh {bench-webpcompare}

Explained

There are 4 benchmark modes all of which saves the preset sample images to working image directory defined by `BENCHDIR='/home/optimise-benchmarks'`. So default location to for images is set to `/home/optimise-benchmarks`

* optimise-images.sh {bench} - this is default image optimisation mode, download preset sample image list, profile it, optimise it and re-profile it
* optimise-images.sh {bench-compare} - enables [Compare Mode](/examples/compare_mode-250417.md)
* optimise-images.sh {bench-webp} - enables [WebP conversion support](/examples/examples-webp-260417.md)
* optimise-images.sh {bench-webpcompare} - enables [WebP conversion + Compare Mode](/examples/examples-webp-compare-260417.md)

Full example of standard `bench-webpcompare` command mode:

    ./optimise-images.sh bench-webpcompare
    
    Benchmark Starting...
    Downloading sample image files
    to /home/optimise-benchmarks
    2017-04-27 04:49:53 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile1.jpg [345814/345814] -> "mobile1.jpg" [1]
    2017-04-27 04:49:54 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile2.jpg [220781/220781] -> "mobile2.jpg" [1]
    2017-04-27 04:49:54 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile3.jpg [267847/267847] -> "mobile3.jpg" [1]
    2017-04-27 04:49:54 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image1.jpg [1440775/1440775] -> "image1.jpg" [1]
    2017-04-27 04:49:55 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image2.jpg [964753/964753] -> "image2.jpg" [1]
    2017-04-27 04:49:55 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image3.jpg [637134/637134] -> "image3.jpg" [1]
    2017-04-27 04:49:56 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image4.jpg [706095/706095] -> "image4.jpg" [1]
    2017-04-27 04:49:56 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image6.jpg [96320/96320] -> "image6.jpg" [1]
    2017-04-27 04:49:56 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image7.jpg [227997/227997] -> "image7.jpg" [1]
    2017-04-27 04:49:57 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_1.jpg [207430/207430] -> "dslr_canon_eos_m6_1.jpg" [1]
    2017-04-27 04:49:58 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_large1.jpg [11963731/11963731] -> "dslr_canon_eos_m6_large1.jpg" [1]
    2017-04-27 04:49:59 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_large2.jpg [10116772/10116772] -> "dslr_canon_eos_m6_large2.jpg" [1]
    2017-04-27 04:50:01 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_77d_1.jpg [7486415/7486415] -> "dslr_canon_eos_77d_1.jpg" [1]
    2017-04-27 04:50:03 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_77d_2.jpg [8316182/8316182] -> "dslr_canon_eos_77d_2.jpg" [1]
    2017-04-27 04:50:04 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_hasselblad_x1d_1.jpg [8780571/8780571] -> "dslr_hasselblad_x1d_1.jpg" [1]
    2017-04-27 04:50:06 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_hasselblad_x1d_2.jpg [13022968/13022968] -> "dslr_hasselblad_x1d_2.jpg" [1]
    2017-04-27 04:50:07 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_leica_m10_1.jpg [9268289/9268289] -> "dslr_leica_m10_1.jpg" [1]
    2017-04-27 04:50:09 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_leica_m10_2.jpg [7438563/7438563] -> "dslr_leica_m10_2.jpg" [1]
    2017-04-27 04:50:11 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d5_1.jpg [10454579/10454579] -> "dslr_nikon_d5_1.jpg" [1]
    2017-04-27 04:50:13 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d5_2.jpg [17263077/17263077] -> "dslr_nikon_d5_2.jpg" [1]
    2017-04-27 04:50:14 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_1.jpg [10806424/10806424] -> "dslr_nikon_d7200_1.jpg" [1]
    2017-04-27 04:50:15 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_2.jpg [3899287/3899287] -> "dslr_nikon_d7200_2.jpg" [1]
    2017-04-27 04:50:17 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_sony_alpha_a99_ii_1.jpg [12444045/12444045] -> "dslr_sony_alpha_a99_ii_1.jpg" [1]
    2017-04-27 04:50:19 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_sony_alpha_a99_ii_2.jpg [25899693/25899693] -> "dslr_sony_alpha_a99_ii_2.jpg" [1]
    2017-04-27 04:50:20 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/samsung_s7_mobile_1.jpg [2100858/2100858] -> "samsung_s7_mobile_1.jpg" [1]
    2017-04-27 04:50:22 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/webp-study-source-firebreathing.png [1206455/1206455] -> "webp-study-source-firebreathing.png" [1]
    2017-04-27 04:50:22 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/webp-study-source-google-chart-tools.png [101911/101911] -> "webp-study-source-google-chart-tools.png" [1]
    2017-04-27 04:50:22 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage1.png [210778/210778] -> "pngimage1.png" [1]
    2017-04-27 04:50:22 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage2.png [40680/40680] -> "pngimage2.png" [1]
    2017-04-27 04:50:23 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage3.png [448000/448000] -> "pngimage3.png" [1]
    2017-04-27 04:50:23 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage4.png [456035/456035] -> "pngimage4.png" [1]
    2017-04-27 04:50:23 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/screenshot1.png [152566/152566] -> "screenshot1.png" [1]
    2017-04-27 04:50:24 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/lenna.png [473831/473831] -> "lenna.png" [1]
    2017-04-27 04:50:24 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-image1.png [400998/400998] -> "png24-image1.png" [1]
    2017-04-27 04:50:24 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-interlaced-image1.png [456949/456949] -> "png24-interlaced-image1.png" [1]
    
    total 162M
    drwxr-xr-x  2 root root 4.0K Apr 27 04:50 .
    drwxr-xr-x. 9 root root 4.0K Apr 27 04:49 ..
    -rw-r--r--  1 root root 7.2M Apr 27 04:50 dslr_canon_eos_77d_1.jpg
    -rw-r--r--  1 root root 8.0M Apr 27 04:50 dslr_canon_eos_77d_2.jpg
    -rw-r--r--  1 root root 203K Apr 27 04:49 dslr_canon_eos_m6_1.jpg
    -rw-r--r--  1 root root  12M Apr 27 04:49 dslr_canon_eos_m6_large1.jpg
    -rw-r--r--  1 root root 9.7M Apr 27 04:49 dslr_canon_eos_m6_large2.jpg
    -rw-r--r--  1 root root 8.4M Apr 27 04:50 dslr_hasselblad_x1d_1.jpg
    -rw-r--r--  1 root root  13M Apr 27 04:50 dslr_hasselblad_x1d_2.jpg
    -rw-r--r--  1 root root 8.9M Apr 27 04:50 dslr_leica_m10_1.jpg
    -rw-r--r--  1 root root 7.1M Apr 27 04:50 dslr_leica_m10_2.jpg
    -rw-r--r--  1 root root  10M Apr 27 04:50 dslr_nikon_d5_1.jpg
    -rw-r--r--  1 root root  17M Apr 27 04:50 dslr_nikon_d5_2.jpg
    -rw-r--r--  1 root root  11M Apr 27 04:50 dslr_nikon_d7200_1.jpg
    -rw-r--r--  1 root root 3.8M Apr 27 04:50 dslr_nikon_d7200_2.jpg
    -rw-r--r--  1 root root  12M Apr 27 04:50 dslr_sony_alpha_a99_ii_1.jpg
    -rw-r--r--  1 root root  25M Apr 27 04:50 dslr_sony_alpha_a99_ii_2.jpg
    -rw-r--r--  1 root root 1.4M Apr 27 04:49 image1.jpg
    -rw-r--r--  1 root root 943K Apr 27 04:49 image2.jpg
    -rw-r--r--  1 root root 623K Apr 27 04:49 image3.jpg
    -rw-r--r--  1 root root 690K Apr 27 04:49 image4.jpg
    -rw-r--r--  1 root root 690K Apr 27 04:50 im age5.jpg
    -rw-r--r--  1 root root  95K Apr 27 04:49 image6.jpg
    -rw-r--r--  1 root root 223K Apr 27 04:49 image7.jpg
    -rw-r--r--  1 root root 463K Apr 27 04:50 lenna.png
    -rw-r--r--  1 root root 338K Apr 27 04:49 mobile1.jpg
    -rw-r--r--  1 root root 216K Apr 27 04:49 mobile2.jpg
    -rw-r--r--  1 root root 262K Apr 27 04:49 mobile3.jpg
    -rw-r--r--  1 root root 392K Apr 27 04:50 png24-image1.png
    -rw-r--r--  1 root root 447K Apr 27 04:50 png24-interlaced-image1.png
    -rw-r--r--  1 root root 206K Apr 27 04:50 pngimage1.png
    -rw-r--r--  1 root root  40K Apr 27 04:50 pngimage2.png
    -rw-r--r--  1 root root 438K Apr 27 04:50 pngimage3.png
    -rw-r--r--  1 root root 446K Apr 27 04:50 pngimage4.png
    -rw-r--r--  1 root root 2.1M Apr 27 04:50 samsung_s7_mobile_1.jpg
    -rw-r--r--  1 root root 149K Apr 27 04:50 screenshot1.png
    -rw-r--r--  1 root root 1.2M Apr 27 04:50 webp-study-source-firebreathing.png
    -rw-r--r--  1 root root 100K Apr 27 04:50 webp-study-source-google-chart-tools.png
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-270417-044953.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 6000 : 4000 : 98 : False : 8 : 7486415 : root : root
    image : dslr_canon_eos_77d_2.jpg : 6000 : 4000 : 98 : False : 8 : 8316182 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root
    image : dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : root
    image : dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : root
    image : dslr_hasselblad_x1d_1.jpg : 8272 : 6200 : 92 : False : 8 : 8780571 : root : root
    image : dslr_hasselblad_x1d_2.jpg : 8272 : 6200 : 92 : False : 8 : 13022968 : root : root
    image : dslr_leica_m10_1.jpg : 5976 : 3984 : 94 : False : 8 : 9268289 : root : root
    image : dslr_leica_m10_2.jpg : 5976 : 3984 : 94 : False : 8 : 7438563 : root : root
    image : dslr_nikon_d5_1.jpg : 5568 : 3712 : 99 : False : 8 : 10454579 : root : root
    image : dslr_nikon_d5_2.jpg : 5568 : 3712 : 99 : False : 8 : 17263077 : root : root
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root
    image : dslr_sony_alpha_a99_ii_1.jpg : 7952 : 5304 : 96 : False : 8 : 12444045 : root : root
    image : dslr_sony_alpha_a99_ii_2.jpg : 7952 : 5304 : 96 : False : 8 : 25899693 : root : root
    image : image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : root
    image : image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : root
    image : image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : root
    image : image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : root
    image : im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : root
    image : image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : root
    image : image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : root
    image : lenna.png : 512 : 512 : 92 : False : 8 : 473831 : root : root
    image : mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : root
    image : mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : root
    image : mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
    image : pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : root
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : root
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : root
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : root
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 101911 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 3358      | 2431       | 93          | 4695297    | 169030698          | 165069          |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-3 Q16 x86_64 2017-03-26
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.452GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 4.05 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image optimisation start
    ------------------------------------------------------------------------------
    ### dslr_canon_eos_77d_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_77d_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_canon_eos_77d_1 -resize 2048x2048\> -write dslr_canon_eos_77d_1_optimal.jpg +delete           mpr:dslr_canon_eos_77d_1 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_77d_1.webp
    jpegoptim -p --max=82 dslr_canon_eos_77d_1_optimal.jpg
    dslr_canon_eos_77d_1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1234808 --> 388237 bytes (68.56%), optimized.
    ### dslr_canon_eos_77d_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_77d_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_canon_eos_77d_2 -resize 2048x2048\> -write dslr_canon_eos_77d_2_optimal.jpg +delete           mpr:dslr_canon_eos_77d_2 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_77d_2.webp
    jpegoptim -p --max=82 dslr_canon_eos_77d_2_optimal.jpg
    dslr_canon_eos_77d_2_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1310455 --> 398208 bytes (69.61%), optimized.
    ### dslr_canon_eos_m6_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_canon_eos_m6_1 -resize 2048x2048\> -write dslr_canon_eos_m6_1_optimal.jpg +delete           mpr:dslr_canon_eos_m6_1 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_m6_1.webp
    jpegoptim -p --max=82 dslr_canon_eos_m6_1_optimal.jpg
    dslr_canon_eos_m6_1_optimal.jpg 1200x800 24bit N JFIF  [OK] 199260 --> 161086 bytes (19.16%), optimized.
    ### dslr_canon_eos_m6_large1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_large1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_canon_eos_m6_large1 -resize 2048x2048\> -write dslr_canon_eos_m6_large1_optimal.jpg +delete           mpr:dslr_canon_eos_m6_large1 -define webp:thread-level=1 -define     webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_m6_large1.webp
    jpegoptim -p --max=82 dslr_canon_eos_m6_large1_optimal.jpg
    dslr_canon_eos_m6_large1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1083047 --> 304069 bytes (71.92%), optimized.
    ### dslr_canon_eos_m6_large2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_large2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_canon_eos_m6_large2 -resize 2048x2048\> -write dslr_canon_eos_m6_large2_optimal.jpg +delete           mpr:dslr_canon_eos_m6_large2 -define webp:thread-level=1 -define     webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_m6_large2.webp
    jpegoptim -p --max=82 dslr_canon_eos_m6_large2_optimal.jpg
    dslr_canon_eos_m6_large2_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1019898 --> 402584 bytes (60.53%), optimized.
    ### dslr_hasselblad_x1d_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_hasselblad_x1d_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_hasselblad_x1d_1 -resize 2048x2048\> -write dslr_hasselblad_x1d_1_optimal.jpg +delete           mpr:dslr_hasselblad_x1d_1 -define webp:thread-level=1 -define webp:method=4 - define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_hasselblad_x1d_1.webp
    jpegoptim -p --max=82 dslr_hasselblad_x1d_1_optimal.jpg
    dslr_hasselblad_x1d_1_optimal.jpg 2048x1535 24bit N JFIF  [OK] 869188 --> 441979 bytes (49.15%), optimized.
    ### dslr_hasselblad_x1d_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_hasselblad_x1d_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_hasselblad_x1d_2 -resize 2048x2048\> -write dslr_hasselblad_x1d_2_optimal.jpg +delete           mpr:dslr_hasselblad_x1d_2 -define webp:thread-level=1 -define webp:method=4 - define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_hasselblad_x1d_2.webp
    jpegoptim -p --max=82 dslr_hasselblad_x1d_2_optimal.jpg
    dslr_hasselblad_x1d_2_optimal.jpg 2048x1535 24bit N JFIF  [OK] 719188 --> 369580 bytes (48.61%), optimized.
    ### dslr_leica_m10_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_leica_m10_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_leica_m10_1 -resize 2048x2048\> -write dslr_leica_m10_1_optimal.jpg +delete           mpr:dslr_leica_m10_1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-   quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_leica_m10_1.webp
    jpegoptim -p --max=82 dslr_leica_m10_1_optimal.jpg
    dslr_leica_m10_1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1160121 --> 438656 bytes (62.19%), optimized.
    ### dslr_leica_m10_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_leica_m10_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_leica_m10_2 -resize 2048x2048\> -write dslr_leica_m10_2_optimal.jpg +delete           mpr:dslr_leica_m10_2 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-   quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_leica_m10_2.webp
    jpegoptim -p --max=82 dslr_leica_m10_2_optimal.jpg
    dslr_leica_m10_2_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1076970 --> 438587 bytes (59.28%), optimized.
    ### dslr_nikon_d5_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d5_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_nikon_d5_1 -resize 2048x2048\> -write dslr_nikon_d5_1_optimal.jpg +delete           mpr:dslr_nikon_d5_1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-   quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d5_1.webp
    jpegoptim -p --max=82 dslr_nikon_d5_1_optimal.jpg
    dslr_nikon_d5_1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1387046 --> 287421 bytes (79.28%), optimized.
    ### dslr_nikon_d5_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d5_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_nikon_d5_2 -resize 2048x2048\> -write dslr_nikon_d5_2_optimal.jpg +delete           mpr:dslr_nikon_d5_2 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-   quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d5_2.webp
    jpegoptim -p --max=82 dslr_nikon_d5_2_optimal.jpg
    dslr_nikon_d5_2_optimal.jpg 2048x1365 24bit N JFIF  [OK] 2048785 --> 310150 bytes (84.86%), optimized.
    ### dslr_nikon_d7200_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_nikon_d7200_1 -resize 2048x2048\> -write dslr_nikon_d7200_1_optimal.jpg +delete           mpr:dslr_nikon_d7200_1 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d7200_1.webp
    jpegoptim -p --max=82 dslr_nikon_d7200_1_optimal.jpg
    dslr_nikon_d7200_1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1238103 --> 374954 bytes (69.72%), optimized.
    ### dslr_nikon_d7200_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_nikon_d7200_2 -resize 2048x2048\> -write dslr_nikon_d7200_2_optimal.jpg +delete           mpr:dslr_nikon_d7200_2 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d7200_2.webp
    jpegoptim -p --max=82 dslr_nikon_d7200_2_optimal.jpg
    dslr_nikon_d7200_2_optimal.jpg 1365x2048 24bit N JFIF  [OK] 620836 --> 516224 bytes (16.85%), optimized.
    ### dslr_sony_alpha_a99_ii_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_sony_alpha_a99_ii_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_sony_alpha_a99_ii_1 -resize 2048x2048\> -write dslr_sony_alpha_a99_ii_1_optimal.jpg +delete           mpr:dslr_sony_alpha_a99_ii_1 -define webp:thread-level=1 -define     webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_sony_alpha_a99_ii_1.webp
    jpegoptim -p --max=82 dslr_sony_alpha_a99_ii_1_optimal.jpg
    dslr_sony_alpha_a99_ii_1_optimal.jpg 2048x1366 24bit N JFIF  [OK] 1157130 --> 349140 bytes (69.83%), optimized.
    ### dslr_sony_alpha_a99_ii_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_sony_alpha_a99_ii_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:dslr_sony_alpha_a99_ii_2 -resize 2048x2048\> -write dslr_sony_alpha_a99_ii_2_optimal.jpg +delete           mpr:dslr_sony_alpha_a99_ii_2 -define webp:thread-level=1 -define     webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_sony_alpha_a99_ii_2.webp
    jpegoptim -p --max=82 dslr_sony_alpha_a99_ii_2_optimal.jpg
    dslr_sony_alpha_a99_ii_2_optimal.jpg 2048x1366 24bit N JFIF  [OK] 1414148 --> 431558 bytes (69.48%), optimized.
    ### image1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image1 -resize 2048x2048\> -write image1_optimal.jpg +delete           mpr:image1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image1.webp
    jpegoptim -p --max=82 image1_optimal.jpg
    image1_optimal.jpg 2048x1290 24bit N JFIF  [OK] 1396539 --> 418884 bytes (70.01%), optimized.
    ### image2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image2 -resize 2048x2048\> -write image2_optimal.jpg +delete           mpr:image2 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image2.webp
    jpegoptim -p --max=82 image2_optimal.jpg
    image2_optimal.jpg 2048x1248 24bit N JFIF  [OK] 962072 --> 282808 bytes (70.60%), optimized.
    ### image3.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image3.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image3 -resize 2048x2048\> -write image3_optimal.jpg +delete           mpr:image3 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image3.webp
    jpegoptim -p --max=82 image3_optimal.jpg
    image3_optimal.jpg 1600x1048 24bit N JFIF  [OK] 542977 --> 271018 bytes (50.09%), optimized.
    ### image4.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image4.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image4 -resize 2048x2048\> -write image4_optimal.jpg +delete           mpr:image4 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image4.webp
    jpegoptim -p --max=82 image4_optimal.jpg
    image4_optimal.jpg 2048x1269 24bit N JFIF  [OK] 696156 --> 269134 bytes (61.34%), optimized.
    ### im age5.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp im age5.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:im age5 -resize 2048x2048\> -write im age5_optimal.jpg +delete           mpr:im age5 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define    webp:lossless=false -quality 75 -resize 2048x2048\> im age5.webp
    jpegoptim -p --max=82 im age5_optimal.jpg
    im age5_optimal.jpg 2048x1269 24bit N JFIF  [OK] 696156 --> 269134 bytes (61.34%), optimized.
    ### image6.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image6.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image6 -resize 2048x2048\> -write image6_optimal.jpg +delete           mpr:image6 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image6.webp
    jpegoptim -p --max=82 image6_optimal.jpg
    image6_optimal.jpg 640x427 24bit N JFIF  [OK] 92928 --> 71496 bytes (23.06%), optimized.
    ### image7.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image7.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:image7 -resize 2048x2048\> -write image7_optimal.jpg +delete           mpr:image7 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -  quality 75 -resize 2048x2048\> image7.webp
    jpegoptim -p --max=82 image7_optimal.jpg
    image7_optimal.jpg 600x400 24bit N JFIF  [OK] 235086 --> 48906 bytes (79.20%), optimized.
    ### lenna.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp lenna.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:lenna -resize 2048x2048\> -write lenna_optimal.png +delete           mpr:lenna -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\>     lenna.webp
    optipng -o2 lenna_optimal.png -preserve -out lenna_optimal.png
    ** Processing: lenna_optimal.png
    512x512 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 475892 bytes
    Input file size = 476117 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 475442
    zc = 9  zm = 8  zs = 3  f = 5         IDAT size = 474898
    
    Selecting parameters:
    zc = 9  zm = 8  zs = 3  f = 5         IDAT size = 474898
    
    Output IDAT size = 474898 bytes (994 bytes decrease)
    Output file size = 474955 bytes (1162 bytes = 0.24% decrease)
    
    ### mobile1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:mobile1 -resize 2048x2048\> -write mobile1_optimal.jpg +delete           mpr:mobile1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define    webp:lossless=false -quality 75 -resize 2048x2048\> mobile1.webp
    jpegoptim -p --max=82 mobile1_optimal.jpg
    mobile1_optimal.jpg 1200x900 24bit N JFIF  [OK] 340252 --> 280918 bytes (17.44%), optimized.
    ### mobile2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:mobile2 -resize 2048x2048\> -write mobile2_optimal.jpg +delete           mpr:mobile2 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define    webp:lossless=false -quality 75 -resize 2048x2048\> mobile2.webp
    jpegoptim -p --max=82 mobile2_optimal.jpg
    mobile2_optimal.jpg 1200x900 24bit N JFIF  [OK] 212594 --> 177339 bytes (16.58%), optimized.
    ### mobile3.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile3.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:mobile3 -resize 2048x2048\> -write mobile3_optimal.jpg +delete           mpr:mobile3 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define    webp:lossless=false -quality 75 -resize 2048x2048\> mobile3.webp
    jpegoptim -p --max=82 mobile3_optimal.jpg
    mobile3_optimal.jpg 1200x900 24bit N JFIF  [OK] 261382 --> 217147 bytes (16.92%), optimized.
    ### png24-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-image1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:png24-image1 -resize 2048x2048\> -write png24-image1_optimal.png +delete           mpr:png24-image1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75     -resize 2048x2048\> png24-image1.webp
    optipng -o2 png24-image1_optimal.png -preserve -out png24-image1_optimal.png
    ** Processing: png24-image1_optimal.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    ### png24-interlaced-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-interlaced-image1.png -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:png24-interlaced-image1 -resize 2048x2048\> -write png24-interlaced-image1_optimal.png +delete           mpr:png24-interlaced-image1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -   define webp:lossless=false -quality 75 -resize 2048x2048\> png24-interlaced-image1.webp
    optipng -o2 png24-interlaced-image1_optimal.png -preserve -out png24-interlaced-image1_optimal.png
    ** Processing: png24-interlaced-image1_optimal.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    ### pngimage1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:pngimage1 -resize 2048x2048\> -write pngimage1_optimal.png +delete           mpr:pngimage1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize     2048x2048\> pngimage1.webp
    optipng -o2 pngimage1_optimal.png -preserve -out pngimage1_optimal.png
    ** Processing: pngimage1_optimal.png
    1623x2048 pixels, 4x8 bits/pixel, RGB+alpha
    Input IDAT size = 1860748 bytes
    Input file size = 1861498 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 246526
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 246526
    
    Output IDAT size = 246526 bytes (1614222 bytes decrease)
    Output file size = 246604 bytes (1614894 bytes = 86.75% decrease)
    
    ### pngimage2.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage2.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:pngimage2 -resize 2048x2048\> -write pngimage2_optimal.png +delete           mpr:pngimage2 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize     2048x2048\> pngimage2.webp
    optipng -o2 pngimage2_optimal.png -preserve -out pngimage2_optimal.png
    ** Processing: pngimage2_optimal.png
    1700x1374 pixels, 4 bits/pixel, 7 colors (3 transparent) in palette
    Input IDAT size = 231700 bytes
    Input file size = 231910 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 19102
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 19102
    
    Output IDAT size = 19102 bytes (212598 bytes decrease)
    Output file size = 19228 bytes (212682 bytes = 91.71% decrease)
    
    ### pngimage3.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage3.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:pngimage3 -resize 2048x2048\> -write pngimage3_optimal.png +delete           mpr:pngimage3 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize     2048x2048\> pngimage3.webp
    optipng -o2 pngimage3_optimal.png -preserve -out pngimage3_optimal.png
    ** Processing: pngimage3_optimal.png
    2000x1370 pixels, 4x8 bits/pixel, RGB+alpha
    Input IDAT size = 1720198 bytes
    Input file size = 1720900 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 284214
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 284214
    
    Output IDAT size = 284214 bytes (1435984 bytes decrease)
    Output file size = 284292 bytes (1436608 bytes = 83.48% decrease)
    
    ### pngimage4.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage4.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:pngimage4 -resize 2048x2048\> -write pngimage4_optimal.png +delete           mpr:pngimage4 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize     2048x2048\> pngimage4.webp
    optipng -o2 pngimage4_optimal.png -preserve -out pngimage4_optimal.png
    ** Processing: pngimage4_optimal.png
    558x465 pixels, 4x8 bits/pixel, RGB+alpha
    Input IDAT size = 506665 bytes
    Input file size = 506923 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 5         IDAT size = 460648
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 454812
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 454812
    
    Output IDAT size = 454812 bytes (51853 bytes decrease)
    Output file size = 454890 bytes (52033 bytes = 10.26% decrease)
    
    ### samsung_s7_mobile_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp samsung_s7_mobile_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip           -write mpr:samsung_s7_mobile_1 -resize 2048x2048\> -write samsung_s7_mobile_1_optimal.jpg +delete           mpr:samsung_s7_mobile_1 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> samsung_s7_mobile_1.webp
    jpegoptim -p --max=82 samsung_s7_mobile_1_optimal.jpg
    samsung_s7_mobile_1_optimal.jpg 2048x1536 24bit N JFIF  [OK] 437104 --> 256253 bytes (41.37%), optimized.
    ### screenshot1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp screenshot1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:screenshot1 -resize 2048x2048\> -write screenshot1_optimal.png +delete           mpr:screenshot1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -   resize 2048x2048\> screenshot1.webp
    optipng -o2 screenshot1_optimal.png -preserve -out screenshot1_optimal.png
    ** Processing: screenshot1_optimal.png
    1484x1095 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 760324 bytes
    Input file size = 760657 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 104619
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 104619
    
    Output IDAT size = 104619 bytes (655705 bytes decrease)
    Output file size = 104676 bytes (655981 bytes = 86.24% decrease)
    
    ### webp-study-source-firebreathing.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-firebreathing.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:webp-study-source-firebreathing -resize 2048x2048\> -write webp-study-source-firebreathing_optimal.png +delete           mpr:webp-study-source-firebreathing -define webp:thread-level=1 -define  webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> webp-study-source-firebreathing.webp
    optipng -o2 webp-study-source-firebreathing_optimal.png -preserve -out webp-study-source-firebreathing_optimal.png
    ** Processing: webp-study-source-firebreathing_optimal.png
    1024x752 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 1199692 bytes
    Input file size = 1200202 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 1194013
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 1194013
    
    Output IDAT size = 1194013 bytes (5679 bytes decrease)
    Output file size = 1194091 bytes (6111 bytes = 0.51% decrease)
    
    ### webp-study-source-google-chart-tools.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-google-chart-tools.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2           -write mpr:webp-study-source-google-chart-tools -resize 2048x2048\> -write webp-study-source-google-chart-tools_optimal.png +delete           mpr:webp-study-source-google-chart-tools -define webp:thread- level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> webp-study-source-google-chart-tools.webp
    optipng -o2 webp-study-source-google-chart-tools_optimal.png -preserve -out webp-study-source-google-chart-tools_optimal.png
    ** Processing: webp-study-source-google-chart-tools_optimal.png
    1024x752 pixels, 4x8 bits/pixel, RGB+alpha
    Input IDAT size = 493994 bytes
    Input file size = 494231 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 107235
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 0  f = 0         IDAT size = 107235
    
    Output IDAT size = 107235 bytes (386759 bytes decrease)
    Output file size = 107292 bytes (386939 bytes = 78.29% decrease)
    
    ------------------------------------------------------------------------------
    Completion Time: 138.93 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-270417-044953.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 6000 : 4000 : 98 : False : 8 : 7486415 : root : root
    image : dslr_canon_eos_77d_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 388237 : root : root
    image : dslr_canon_eos_77d_1.webp : 2048 : 1365 : 92 : False : 8 : 170488 : root : root
    image : dslr_canon_eos_77d_2.jpg : 6000 : 4000 : 98 : False : 8 : 8316182 : root : root
    image : dslr_canon_eos_77d_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 398208 : root : root
    image : dslr_canon_eos_77d_2.webp : 2048 : 1365 : 92 : False : 8 : 165680 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root
    image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : root
    image : dslr_canon_eos_m6_1.webp : 1200 : 800 : 92 : False : 8 : 61544 : root : root
    image : dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : root
    image : dslr_canon_eos_m6_large1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 304069 : root : root
    image : dslr_canon_eos_m6_large1.webp : 2048 : 1365 : 92 : False : 8 : 106656 : root : root
    image : dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : root
    image : dslr_canon_eos_m6_large2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 402584 : root : root
    image : dslr_canon_eos_m6_large2.webp : 2048 : 1365 : 92 : False : 8 : 162168 : root : root
    image : dslr_hasselblad_x1d_1.jpg : 8272 : 6200 : 92 : False : 8 : 8780571 : root : root
    image : dslr_hasselblad_x1d_1_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 441979 : root : root
    image : dslr_hasselblad_x1d_1.webp : 2048 : 1535 : 92 : False : 8 : 169388 : root : root
    image : dslr_hasselblad_x1d_2.jpg : 8272 : 6200 : 92 : False : 8 : 13022968 : root : root
    image : dslr_hasselblad_x1d_2_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 369580 : root : root
    image : dslr_hasselblad_x1d_2.webp : 2048 : 1535 : 92 : False : 8 : 115382 : root : root
    image : dslr_leica_m10_1.jpg : 5976 : 3984 : 94 : False : 8 : 9268289 : root : root
    image : dslr_leica_m10_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438656 : root : root
    image : dslr_leica_m10_1.webp : 2048 : 1365 : 92 : False : 8 : 201494 : root : root
    image : dslr_leica_m10_2.jpg : 5976 : 3984 : 94 : False : 8 : 7438563 : root : root
    image : dslr_leica_m10_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438587 : root : root
    image : dslr_leica_m10_2.webp : 2048 : 1365 : 92 : False : 8 : 212046 : root : root
    image : dslr_nikon_d5_1.jpg : 5568 : 3712 : 99 : False : 8 : 10454579 : root : root
    image : dslr_nikon_d5_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 287421 : root : root
    image : dslr_nikon_d5_1.webp : 2048 : 1365 : 92 : False : 8 : 110366 : root : root
    image : dslr_nikon_d5_2.jpg : 5568 : 3712 : 99 : False : 8 : 17263077 : root : root
    image : dslr_nikon_d5_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 310150 : root : root
    image : dslr_nikon_d5_2.webp : 2048 : 1365 : 92 : False : 8 : 99214 : root : root
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root
    image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : root
    image : dslr_nikon_d7200_1.webp : 2048 : 1365 : 92 : False : 8 : 173414 : root : root
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root
    image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : root
    image : dslr_nikon_d7200_2.webp : 1365 : 2048 : 92 : False : 8 : 212754 : root : root
    image : dslr_sony_alpha_a99_ii_1.jpg : 7952 : 5304 : 96 : False : 8 : 12444045 : root : root
    image : dslr_sony_alpha_a99_ii_1_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 349140 : root : root
    image : dslr_sony_alpha_a99_ii_1.webp : 2048 : 1366 : 92 : False : 8 : 162100 : root : root
    image : dslr_sony_alpha_a99_ii_2.jpg : 7952 : 5304 : 96 : False : 8 : 25899693 : root : root
    image : dslr_sony_alpha_a99_ii_2_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 431558 : root : root
    image : dslr_sony_alpha_a99_ii_2.webp : 2048 : 1366 : 92 : False : 8 : 178200 : root : root
    image : image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : root
    image : image1_optimal.jpg : 2048 : 1290 : 82 : False : 8 : 418884 : root : root
    image : image1.webp : 2048 : 1290 : 92 : False : 8 : 238790 : root : root
    image : image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : root
    image : image2_optimal.jpg : 2048 : 1248 : 82 : False : 8 : 282808 : root : root
    image : image2.webp : 2048 : 1248 : 92 : False : 8 : 115156 : root : root
    image : image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : root
    image : image3_optimal.jpg : 1600 : 1048 : 82 : False : 8 : 271018 : root : root
    image : image3.webp : 1600 : 1048 : 92 : False : 8 : 149990 : root : root
    image : image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : root
    image : image4_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : root
    image : image4.webp : 2048 : 1269 : 92 : False : 8 : 117758 : root : root
    image : im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : root
    image : im age5_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : root
    image : im age5.webp : 2048 : 1269 : 92 : False : 8 : 117758 : root : root
    image : image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : root
    image : image6_optimal.jpg : 640 : 427 : 82 : False : 8 : 71496 : root : root
    image : image6.webp : 640 : 427 : 92 : False : 8 : 48786 : root : root
    image : image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : root
    image : image7_optimal.jpg : 600 : 400 : 82 : False : 8 : 48906 : root : root
    image : image7.webp : 600 : 400 : 92 : False : 8 : 27068 : root : root
    image : lenna_optimal.png : 512 : 512 : 92 : False : 8 : 474955 : root : root
    image : lenna.png : 512 : 512 : 92 : False : 8 : 473831 : root : root
    image : lenna.webp : 512 : 512 : 92 : False : 8 : 20572 : root : root
    image : mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : root
    image : mobile1_optimal.jpg : 1200 : 900 : 82 : False : 8 : 280918 : root : root
    image : mobile1.webp : 1200 : 900 : 92 : False : 8 : 153574 : root : root
    image : mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : root
    image : mobile2_optimal.jpg : 1200 : 900 : 82 : False : 8 : 177339 : root : root
    image : mobile2.webp : 1200 : 900 : 92 : False : 8 : 73178 : root : root
    image : mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : root
    image : mobile3_optimal.jpg : 1200 : 900 : 82 : False : 8 : 217147 : root : root
    image : mobile3.webp : 1200 : 900 : 92 : False : 8 : 90900 : root : root
    image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
    image : png24-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : root
    image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
    image : png24-interlaced-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : root
    image : pngimage1_optimal.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : root
    image : pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : root
    image : pngimage1.webp : 1623 : 2048 : 92 : True : 8 : 87360 : root : root
    image : pngimage2_optimal.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : root
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : root
    image : pngimage2.webp : 1700 : 1374 : 92 : True : 8 : 37534 : root : root
    image : pngimage3_optimal.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : root
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : root
    image : pngimage3.webp : 2000 : 1370 : 92 : True : 8 : 198494 : root : root
    image : pngimage4_optimal.png : 558 : 465 : 92 : True : 8 : 454890 : root : root
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : root
    image : pngimage4.webp : 558 : 465 : 92 : True : 8 : 46422 : root : root
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root
    image : samsung_s7_mobile_1_optimal.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : root
    image : samsung_s7_mobile_1.webp : 2048 : 1536 : 92 : False : 8 : 69490 : root : root
    image : screenshot1_optimal.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : root
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : root
    image : screenshot1.webp : 1484 : 1095 : 92 : False : 8 : 79244 : root : root
    image : webp-study-source-firebreathing_optimal.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
    image : webp-study-source-firebreathing.webp : 1024 : 752 : 92 : False : 8 : 71860 : root : root
    image : webp-study-source-google-chart-tools_optimal.png : 1024 : 752 : 92 : True : 8 : 107292 : root : root
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 101911 : root : root
    image : webp-study-source-google-chart-tools.webp : 1024 : 752 : 92 : True : 8 : 53924 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 2471      | 1789       | 93          | 2405329    | 173183658          | 169125          |
    
    ------------------------------------------------------------------------------
    Optimised Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1583      | 1147       | 85          | 328712     | 11833624           | 11556           |
    
    ------------------------------------------------------------------------------
    Optimised WebP Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1583      | 1147       | 92          | 115360     | 4152960            | 4056            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.8-3 Q16 x86_64 2017-03-26
    Resource limits:
    Width: 214.7MP
    Height: 214.7MP
    Area: 67.057GP
    Memory: 31.226GiB
    Map: 62.452GiB
    Disk: unlimited
    File: 196608
    Thread: 4
    Throttle: 0
    Time: unlimited
    ------------------------------------------------------------------------------
    Completion Time: 5.61 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    Benchmarked Completeion Time: 179.96 seconds
    ------------------------------------------------------------------------------