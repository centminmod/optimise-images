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

* optimise-images.sh {bench} - this is default image optimisation mode, download preset sample image list, profile it, optimise it and re-profile it
* optimise-images.sh {bench-compare} - enables [Compare Mode](/examples/compare_mode-250417.md)
* optimise-images.sh {bench-webp} - enables [WebP conversion support](/examples/examples-webp-260417.md)
* optimise-images.sh {bench-webpcompare} - enables [WebP conversion + Compare Mode](/examples/examples-webp-compare-260417.md)

Full example of standard `bench` command mode:

    ./optimise-images.sh bench
    
    Benchmark Starting...
    Downloading sample image files
    2017-04-27 03:03:45 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile1.jpg [345814/345814] -> "mobile1.jpg" [1]
    2017-04-27 03:03:45 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile2.jpg [220781/220781] -> "mobile2.jpg" [1]
    2017-04-27 03:03:46 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/mobile3.jpg [267847/267847] -> "mobile3.jpg" [1]
    2017-04-27 03:03:46 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image1.jpg [1440775/1440775] -> "image1.jpg" [1]
    2017-04-27 03:03:47 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image2.jpg [964753/964753] -> "image2.jpg" [1]
    2017-04-27 03:03:47 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image3.jpg [637134/637134] -> "image3.jpg" [1]
    2017-04-27 03:03:47 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image4.jpg [706095/706095] -> "image4.jpg" [1]
    2017-04-27 03:03:48 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image6.jpg [96320/96320] -> "image6.jpg" [1]
    2017-04-27 03:03:48 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/image7.jpg [227997/227997] -> "image7.jpg" [1]
    2017-04-27 03:03:49 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_1.jpg [207430/207430] -> "dslr_canon_eos_m6_1.jpg" [1]
    2017-04-27 03:03:59 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_large1.jpg [11963731/11963731] -> "dslr_canon_eos_m6_large1.jpg" [1]
    2017-04-27 03:04:07 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_large2.jpg [10116772/10116772] -> "dslr_canon_eos_m6_large2.jpg" [1]
    2017-04-27 03:04:08 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_77d_1.jpg [7486415/7486415] -> "dslr_canon_eos_77d_1.jpg" [1]
    2017-04-27 03:04:14 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_77d_2.jpg [8316182/8316182] -> "dslr_canon_eos_77d_2.jpg" [1]
    2017-04-27 03:04:21 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_hasselblad_x1d_1.jpg [8780571/8780571] -> "dslr_hasselblad_x1d_1.jpg" [1]
    2017-04-27 03:04:24 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_hasselblad_x1d_2.jpg [13022968/13022968] -> "dslr_hasselblad_x1d_2.jpg" [1]
    2017-04-27 03:04:33 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_leica_m10_1.jpg [9268289/9268289] -> "dslr_leica_m10_1.jpg" [1]
    2017-04-27 03:04:39 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_leica_m10_2.jpg [7438563/7438563] -> "dslr_leica_m10_2.jpg" [1]
    2017-04-27 03:04:49 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d5_1.jpg [10454579/10454579] -> "dslr_nikon_d5_1.jpg" [1]
    2017-04-27 03:05:05 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d5_2.jpg [17263077/17263077] -> "dslr_nikon_d5_2.jpg" [1]
    2017-04-27 03:05:06 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_1.jpg [10806424/10806424] -> "dslr_nikon_d7200_1.jpg" [1]
    2017-04-27 03:05:10 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_2.jpg [3899287/3899287] -> "dslr_nikon_d7200_2.jpg" [1]
    2017-04-27 03:05:11 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_sony_alpha_a99_ii_1.jpg [12444045/12444045] -> "dslr_sony_alpha_a99_ii_1.jpg" [1]
    2017-04-27 03:05:39 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_sony_alpha_a99_ii_2.jpg [25899693/25899693] -> "dslr_sony_alpha_a99_ii_2.jpg" [1]
    2017-04-27 03:05:40 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/samsung_s7_mobile_1.jpg [2100858/2100858] -> "samsung_s7_mobile_1.jpg" [1]
    2017-04-27 03:05:41 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/webp-study-source-firebreathing.png [1206455/1206455] -> "webp-study-source-firebreathing.png" [1]
    2017-04-27 03:05:41 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage2.png [40680/40680] -> "pngimage2.png" [1]
    2017-04-27 03:05:42 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage3.png [448000/448000] -> "pngimage3.png" [1]
    2017-04-27 03:05:42 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/pngimage4.png [456035/456035] -> "pngimage4.png" [1]
    2017-04-27 03:05:42 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/screenshot1.png [152566/152566] -> "screenshot1.png" [1]
    2017-04-27 03:05:43 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-image1.png [400998/400998] -> "png24-image1.png" [1]
    2017-04-27 03:05:44 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-interlaced-image1.png [456949/456949] -> "png24-interlaced-image1.png" [1]
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-270417-030345.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 2048 : 1365 : 82 : False : 8 : 7486415 : root : root
    image : dslr_canon_eos_77d_2.jpg : 2048 : 1365 : 82 : False : 8 : 8316182 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 207430 : root : root
    image : dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : False : 8 : 11963731 : root : root
    image : dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : False : 8 : 10116772 : root : root
    image : dslr_hasselblad_x1d_1.jpg : 2048 : 1535 : 82 : False : 8 : 8780571 : root : root
    image : dslr_hasselblad_x1d_2.jpg : 2048 : 1535 : 82 : False : 8 : 13022968 : root : root
    image : dslr_leica_m10_1.jpg : 2048 : 1365 : 82 : False : 8 : 9268289 : root : root
    image : dslr_leica_m10_2.jpg : 2048 : 1365 : 82 : False : 8 : 7438563 : root : root
    image : dslr_nikon_d5_1.jpg : 2048 : 1365 : 82 : False : 8 : 10454579 : root : root
    image : dslr_nikon_d5_2.jpg : 2048 : 1365 : 82 : False : 8 : 17263077 : root : root
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 10806424 : root : root
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 3899287 : root : root
    image : dslr_sony_alpha_a99_ii_1.jpg : 2048 : 1366 : 82 : False : 8 : 12444045 : root : root
    image : dslr_sony_alpha_a99_ii_2.jpg : 2048 : 1366 : 82 : False : 8 : 25899693 : root : root
    image : image1.jpg : 2048 : 1290 : 82 : False : 8 : 1440775 : root : root
    image : image2.jpg : 2048 : 1248 : 82 : False : 8 : 964753 : root : root
    image : image3.jpg : 1600 : 1048 : 82 : False : 8 : 637134 : root : root
    image : image4.jpg : 2048 : 1269 : 82 : False : 8 : 706095 : root : root
    image : im age5.jpg : 2048 : 1269 : 82 : False : 8 : 706095 : root : root
    image : image6.jpg : 640 : 427 : 82 : False : 8 : 96320 : root : root
    image : image7.jpg : 600 : 400 : 82 : False : 8 : 227997 : root : root
    image : lenna.png : 512 : 512 : 92 : False : 8 : 474955 : root : root
    image : mobile1.jpg : 1200 : 900 : 82 : False : 8 : 345814 : root : root
    image : mobile2.jpg : 1200 : 900 : 82 : False : 8 : 220781 : root : root
    image : mobile3.jpg : 1200 : 900 : 82 : False : 8 : 267847 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
    image : pngimage1.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : root
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : root
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : root
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : root
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 2100858 : root : root
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 107292 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1583      | 1147       | 85          | 4696473    | 169073029          | 165110          |
    
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
    Completion Time: 0.60 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image optimisation start
    ------------------------------------------------------------------------------
    ### dslr_canon_eos_77d_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_77d_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -   interlace none -strip -resize 2048x2048\> dslr_canon_eos_77d_1.jpg
    jpegoptim -p --max=82 dslr_canon_eos_77d_1.jpg
    dslr_canon_eos_77d_1.jpg 2048x1365 24bit N JFIF  [OK] 388216 --> 388147 bytes (0.02%), optimized.
    ### dslr_canon_eos_77d_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_77d_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -   interlace none -strip -resize 2048x2048\> dslr_canon_eos_77d_2.jpg
    jpegoptim -p --max=82 dslr_canon_eos_77d_2.jpg
    dslr_canon_eos_77d_2.jpg 2048x1365 24bit N JFIF  [OK] 398096 --> 398003 bytes (0.02%), optimized.
    ### dslr_canon_eos_m6_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -    interlace none -strip -resize 2048x2048\> dslr_canon_eos_m6_1.jpg
    jpegoptim -p --max=82 dslr_canon_eos_m6_1.jpg
    dslr_canon_eos_m6_1.jpg 1200x800 24bit N JFIF  [OK] 161044 --> 161017 bytes (0.02%), optimized.
    ### dslr_canon_eos_m6_large1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_large1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.    045 -interlace none -strip -resize 2048x2048\> dslr_canon_eos_m6_large1.jpg
    jpegoptim -p --max=82 dslr_canon_eos_m6_large1.jpg
    dslr_canon_eos_m6_large1.jpg 2048x1365 24bit N JFIF  [OK] 304051 --> 303953 bytes (0.03%), optimized.
    ### dslr_canon_eos_m6_large2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_large2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.    045 -interlace none -strip -resize 2048x2048\> dslr_canon_eos_m6_large2.jpg
    jpegoptim -p --max=82 dslr_canon_eos_m6_large2.jpg
    dslr_canon_eos_m6_large2.jpg 2048x1365 24bit N JFIF  [OK] 402578 --> 402525 bytes (0.01%), optimized.
    ### dslr_hasselblad_x1d_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_hasselblad_x1d_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045    -interlace none -strip -resize 2048x2048\> dslr_hasselblad_x1d_1.jpg
    jpegoptim -p --max=82 dslr_hasselblad_x1d_1.jpg
    dslr_hasselblad_x1d_1.jpg 2048x1535 24bit N JFIF  [OK] 441704 --> 441704 bytes (0.00%), skipped.
    ### dslr_hasselblad_x1d_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_hasselblad_x1d_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045    -interlace none -strip -resize 2048x2048\> dslr_hasselblad_x1d_2.jpg
    jpegoptim -p --max=82 dslr_hasselblad_x1d_2.jpg
    dslr_hasselblad_x1d_2.jpg 2048x1535 24bit N JFIF  [OK] 369782 --> 369700 bytes (0.02%), optimized.
    ### dslr_leica_m10_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_leica_m10_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -   interlace none -strip -resize 2048x2048\> dslr_leica_m10_1.jpg
    jpegoptim -p --max=82 dslr_leica_m10_1.jpg
    dslr_leica_m10_1.jpg 2048x1365 24bit N JFIF  [OK] 437189 --> 436620 bytes (0.13%), optimized.
    ### dslr_leica_m10_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_leica_m10_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -   interlace none -strip -resize 2048x2048\> dslr_leica_m10_2.jpg
    jpegoptim -p --max=82 dslr_leica_m10_2.jpg
    dslr_leica_m10_2.jpg 2048x1365 24bit N JFIF  [OK] 437806 --> 437568 bytes (0.05%), optimized.
    ### dslr_nikon_d5_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d5_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -    interlace none -strip -resize 2048x2048\> dslr_nikon_d5_1.jpg
    jpegoptim -p --max=82 dslr_nikon_d5_1.jpg
    dslr_nikon_d5_1.jpg 2048x1365 24bit N JFIF  [OK] 287366 --> 287306 bytes (0.02%), optimized.
    ### dslr_nikon_d5_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d5_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -    interlace none -strip -resize 2048x2048\> dslr_nikon_d5_2.jpg
    jpegoptim -p --max=82 dslr_nikon_d5_2.jpg
    dslr_nikon_d5_2.jpg 2048x1365 24bit N JFIF  [OK] 309949 --> 309904 bytes (0.01%), optimized.
    ### dslr_nikon_d7200_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 - interlace none -strip -resize 2048x2048\> dslr_nikon_d7200_1.jpg
    jpegoptim -p --max=82 dslr_nikon_d7200_1.jpg
    dslr_nikon_d7200_1.jpg 2048x1365 24bit N JFIF  [OK] 374697 --> 374670 bytes (0.01%), optimized.
    ### dslr_nikon_d7200_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 - interlace none -strip -resize 2048x2048\> dslr_nikon_d7200_2.jpg
    jpegoptim -p --max=82 dslr_nikon_d7200_2.jpg
    dslr_nikon_d7200_2.jpg 1365x2048 24bit N JFIF  [OK] 516092 --> 516092 bytes (0.00%), skipped.
    ### dslr_sony_alpha_a99_ii_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_sony_alpha_a99_ii_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.    045 -interlace none -strip -resize 2048x2048\> dslr_sony_alpha_a99_ii_1.jpg
    jpegoptim -p --max=82 dslr_sony_alpha_a99_ii_1.jpg
    dslr_sony_alpha_a99_ii_1.jpg 2048x1366 24bit N JFIF  [OK] 347416 --> 346645 bytes (0.22%), optimized.
    ### dslr_sony_alpha_a99_ii_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_sony_alpha_a99_ii_2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.    045 -interlace none -strip -resize 2048x2048\> dslr_sony_alpha_a99_ii_2.jpg
    jpegoptim -p --max=82 dslr_sony_alpha_a99_ii_2.jpg
    dslr_sony_alpha_a99_ii_2.jpg 2048x1366 24bit N JFIF  [OK] 431134 --> 430958 bytes (0.04%), optimized.
    ### image1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image1.jpg
    jpegoptim -p --max=82 image1.jpg
    image1.jpg 2048x1290 24bit N JFIF  [OK] 417454 --> 417283 bytes (0.04%), optimized.
    ### image2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image2.jpg
    jpegoptim -p --max=82 image2.jpg
    image2.jpg 2048x1248 24bit N JFIF  [OK] 282381 --> 282381 bytes (0.00%), skipped.
    ### image3.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image3.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image3.jpg
    jpegoptim -p --max=82 image3.jpg
    image3.jpg 1600x1048 24bit N JFIF  [OK] 271052 --> 271003 bytes (0.02%), optimized.
    ### image4.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image4.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image4.jpg
    jpegoptim -p --max=82 image4.jpg
    image4.jpg 2048x1269 24bit N JFIF  [OK] 269211 --> 269210 bytes (0.00%), optimized.
    ### im age5.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp im age5.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace   none -strip -resize 2048x2048\> im age5.jpg
    jpegoptim -p --max=82 im age5.jpg
    im age5.jpg 2048x1269 24bit N JFIF  [OK] 269211 --> 269210 bytes (0.00%), optimized.
    ### image6.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image6.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image6.jpg
    jpegoptim -p --max=82 image6.jpg
    image6.jpg 640x427 24bit N JFIF  [OK] 71038 --> 70950 bytes (0.12%), optimized.
    ### image7.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp image7.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace    none -strip -resize 2048x2048\> image7.jpg
    jpegoptim -p --max=82 image7.jpg
    image7.jpg 600x400 24bit N JFIF  [OK] 48870 --> 48865 bytes (0.01%), optimized.
    ### lenna.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp lenna.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> lenna.   png
    optipng -o2 lenna.png -preserve -out lenna.png
    ** Processing: lenna.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace   none -strip -resize 2048x2048\> mobile1.jpg
    jpegoptim -p --max=82 mobile1.jpg
    mobile1.jpg 1200x900 24bit N JFIF  [OK] 280798 --> 280739 bytes (0.02%), optimized.
    ### mobile2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile2.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace   none -strip -resize 2048x2048\> mobile2.jpg
    jpegoptim -p --max=82 mobile2.jpg
    mobile2.jpg 1200x900 24bit N JFIF  [OK] 177322 --> 177322 bytes (0.00%), skipped.
    ### mobile3.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp mobile3.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace   none -strip -resize 2048x2048\> mobile3.jpg
    jpegoptim -p --max=82 mobile3.jpg
    mobile3.jpg 1200x900 24bit N JFIF  [OK] 217112 --> 217104 bytes (0.00%), optimized.
    ### png24-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-image1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>    png24-image1.png
    optipng -o2 png24-image1.png -preserve -out png24-image1.png
    ** Processing: png24-image1.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    ### png24-interlaced-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-interlaced-image1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize    2048x2048\> png24-interlaced-image1.png
    optipng -o2 png24-interlaced-image1.png -preserve -out png24-interlaced-image1.png
    ** Processing: png24-interlaced-image1.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    ### pngimage1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>  pngimage1.png
    optipng -o2 pngimage1.png -preserve -out pngimage1.png
    ** Processing: pngimage1.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage2.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>  pngimage2.png
    optipng -o2 pngimage2.png -preserve -out pngimage2.png
    ** Processing: pngimage2.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage3.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>  pngimage3.png
    optipng -o2 pngimage3.png -preserve -out pngimage3.png
    ** Processing: pngimage3.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp pngimage4.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>  pngimage4.png
    optipng -o2 pngimage4.png -preserve -out pngimage4.png
    ** Processing: pngimage4.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp samsung_s7_mobile_1.jpg -define jpeg:size=4096x4096 -filter Triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -    interlace none -strip -resize 2048x2048\> samsung_s7_mobile_1.jpg
    jpegoptim -p --max=82 samsung_s7_mobile_1.jpg
    samsung_s7_mobile_1.jpg 2048x1536 24bit N JFIF  [OK] 256360 --> 256360 bytes (0.00%), skipped.
    ### screenshot1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp screenshot1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\>    screenshot1.png
    optipng -o2 screenshot1.png -preserve -out screenshot1.png
    ** Processing: screenshot1.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-firebreathing.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2    -resize 2048x2048\> webp-study-source-firebreathing.png
    optipng -o2 webp-study-source-firebreathing.png -preserve -out webp-study-source-firebreathing.png
    ** Processing: webp-study-source-firebreathing.png
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
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-google-chart-tools.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression- strategy=2 -resize 2048x2048\> webp-study-source-google-chart-tools.png
    optipng -o2 webp-study-source-google-chart-tools.png -preserve -out webp-study-source-google-chart-tools.png
    ** Processing: webp-study-source-google-chart-tools.png
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
    Completion Time: 33.86 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-270417-030345.log
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 2048 : 1365 : 82 : False : 8 : 388147 : root : root
    image : dslr_canon_eos_77d_2.jpg : 2048 : 1365 : 82 : False : 8 : 398003 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161017 : root : root
    image : dslr_canon_eos_m6_large1.jpg : 2048 : 1365 : 82 : False : 8 : 303953 : root : root
    image : dslr_canon_eos_m6_large2.jpg : 2048 : 1365 : 82 : False : 8 : 402525 : root : root
    image : dslr_hasselblad_x1d_1.jpg : 2048 : 1535 : 82 : False : 8 : 441704 : root : root
    image : dslr_hasselblad_x1d_2.jpg : 2048 : 1535 : 82 : False : 8 : 369700 : root : root
    image : dslr_leica_m10_1.jpg : 2048 : 1365 : 82 : False : 8 : 436620 : root : root
    image : dslr_leica_m10_2.jpg : 2048 : 1365 : 82 : False : 8 : 437568 : root : root
    image : dslr_nikon_d5_1.jpg : 2048 : 1365 : 82 : False : 8 : 287306 : root : root
    image : dslr_nikon_d5_2.jpg : 2048 : 1365 : 82 : False : 8 : 309904 : root : root
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 374670 : root : root
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 516092 : root : root
    image : dslr_sony_alpha_a99_ii_1.jpg : 2048 : 1366 : 82 : False : 8 : 346645 : root : root
    image : dslr_sony_alpha_a99_ii_2.jpg : 2048 : 1366 : 82 : False : 8 : 430958 : root : root
    image : image1.jpg : 2048 : 1290 : 82 : False : 8 : 417283 : root : root
    image : image2.jpg : 2048 : 1248 : 82 : False : 8 : 282381 : root : root
    image : image3.jpg : 1600 : 1048 : 82 : False : 8 : 271003 : root : root
    image : image4.jpg : 2048 : 1269 : 82 : False : 8 : 269210 : root : root
    image : im age5.jpg : 2048 : 1269 : 82 : False : 8 : 269210 : root : root
    image : image6.jpg : 640 : 427 : 82 : False : 8 : 70950 : root : root
    image : image7.jpg : 600 : 400 : 82 : False : 8 : 48865 : root : root
    image : lenna.png : 512 : 512 : 92 : False : 8 : 474955 : root : root
    image : mobile1.jpg : 1200 : 900 : 82 : False : 8 : 280739 : root : root
    image : mobile2.jpg : 1200 : 900 : 82 : False : 8 : 177322 : root : root
    image : mobile3.jpg : 1200 : 900 : 82 : False : 8 : 217104 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : pngimage1.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : root
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : root
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : root
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 454890 : root : root
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256360 : root : root
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : root
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 107292 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1583      | 1147       | 85          | 328428     | 11823393           | 11546           |
    
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
    Completion Time: 0.61 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    Benchmarked Completeion Time: 154.19 seconds
    ------------------------------------------------------------------------------
