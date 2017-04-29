[optimise-images.sh](https://github.com/centminmod/optimise-images) added new benchmark mode option to test against preset sample images as well as support for alternative PNG compressor to OptinPNG, ZopfliPNG and alternative JPG compressor to JpegOtim, Google Guetzli and Mozilla MozJPEG. You can jump straight to the summary [here](#summary) and all the original and resized/optimised images can be found [here](/examples/benchmark-mode-compare-compressors1-290417/).

Usage options:

    ./optimise-images.sh 
    
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {profile} /PATH/TO/DIRECTORY/WITH/IMAGES
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

Explained

There are 4 benchmark modes all of which saves the preset sample images to working image directory defined by `BENCHDIR='/home/optimise-benchmarks'`. So default location to for images is set to `/home/optimise-benchmarks`. There's a 3rd paramater for all which sets `TESTFILES_MINIMAL='n'` to download all sample images instead of default `TESTFILES_MINIMAL='y'` which downloads a smaller minimal set of png and jpg images (4 of each).

* optimise-images.sh {bench} - this is default image optimisation mode, download preset sample image list, profile it, optimise it and re-profile it
* optimise-images.sh {bench-compare} - enables [Compare Mode](/examples/compare_mode-250417.md)
* optimise-images.sh {bench-webp} - enables [WebP conversion support](/examples/examples-webp-260417.md)
* optimise-images.sh {bench-webpcompare} - enables [WebP conversion + Compare Mode](/examples/examples-webp-compare-260417.md)

For this example will be testing `bench-webpcompare` mode but with all compressors enabled. This will give you a break down of original image, the resized to `MAXRES=2048` and optimised versions for png, jpg and webp. You can jump straight to the summary [here](#summary) and all the original and resized/optimised images can be found [here](/examples/benchmark-mode-compare-compressors1-290417/)..

    # additional image optimisations after imagemagick
    # resizing
    # choose one of the 3 JPEGOPTIM, GUETZLI or MOZJPEG
    JPEGOPTIM='y'
    GUETZLI='y'
    MOZJPEG='y'
    # choose either OPTIPNG or ZOPFLIPNG
    OPTIPNG='y'
    ZOPFLIPNG='y'

`bench-webpcompare` auto enables `IMAGICK_WEBP='y'` but if you want to do this on your own directory defined path, you need to se `IMAGICK_WEBP='y'` yourself too.

Run `bench-webpcompare` command mode:

    ./optimise-images.sh bench-webpcompare

This will first download the minimal set of sample images to `/home/optimise-benchmarks`

    Benchmark Starting...
    Downloading sample image files
    to /home/optimise-benchmarks
    2017-04-29 10:32:05 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/samsung_s7_mobile_1.jpg [2100858/2100858] -> "samsung_s7_mobile_1.jpg" [1]
    2017-04-29 10:32:05 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_canon_eos_m6_1.jpg [207430/207430] -> "dslr_canon_eos_m6_1.jpg" [1]
    2017-04-29 10:32:06 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_1.jpg [10806424/10806424] -> "dslr_nikon_d7200_1.jpg" [1]
    2017-04-29 10:32:07 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/dslr_nikon_d7200_2.jpg [3899287/3899287] -> "dslr_nikon_d7200_2.jpg" [1]
    2017-04-29 10:32:07 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/bees.png [177424/177424] -> "bees.png" [1]
    2017-04-29 10:32:08 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/webp-study-source-firebreathing.png [1206455/1206455] -> "webp-study-source-firebreathing.png" [1]
    2017-04-29 10:32:08 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-image1.png [400998/400998] -> "png24-image1.png" [1]
    2017-04-29 10:32:08 URL:https://raw.githubusercontent.com/centminmod/optimise-images/master/images/png24-interlaced-image1.png [456949/456949] -> "png24-interlaced-image1.png" [1]
    
    total 19M
    drwxr-xr-x  2 root root 4.0K Apr 29 10:32 .
    drwxr-xr-x. 9 root root 4.0K Apr 29 10:32 ..
    -rw-r--r--  1 root root 174K Apr 29 10:32 bees.png
    -rw-r--r--  1 root root 203K Apr 29 10:32 dslr_canon_eos_m6_1.jpg
    -rw-r--r--  1 root root  11M Apr 29 10:32 dslr_nikon_d7200_1.jpg
    -rw-r--r--  1 root root 3.8M Apr 29 10:32 dslr_nikon_d7200_2.jpg
    -rw-r--r--  1 root root 392K Apr 29 10:32 png24-image1.png
    -rw-r--r--  1 root root 447K Apr 29 10:32 png24-interlaced-image1.png
    -rw-r--r--  1 root root 2.1M Apr 29 10:32 samsung_s7_mobile_1.jpg
    -rw-r--r--  1 root root 1.2M Apr 29 10:32 webp-study-source-firebreathing.png

The show you the profile results before resize + optimisation of the original minimal set of sample images

    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-290417-103204.log
    ------------------------------------------------------------------------------
    image : bees.png : 444 : 258 : 92 : False : 8 : 177424 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 2238      | 1954       | 92          | 2406978    | 19255825           | 18805           |
    
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
    Completion Time: 0.50 seconds
    ------------------------------------------------------------------------------

The resize and optimisation part

    ------------------------------------------------------------------------------
    image optimisation start
    ------------------------------------------------------------------------------
    ### dslr_nikon_d7200_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip             -write mpr:dslr_nikon_d7200_1 -resize 2048x2048\> -write dslr_nikon_d7200_1_optimal.jpg +delete             mpr:dslr_nikon_d7200_1 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d7200_1.webp
    jpegoptim -p --max=82 dslr_nikon_d7200_1_optimal.jpg
    dslr_nikon_d7200_1_optimal.jpg 2048x1365 24bit N JFIF  [OK] 1238103 --> 374954 bytes (69.72%), optimized.
    /opt/guetzli/bin/Release/guetzli --quality 85 --verbose dslr_nikon_d7200_1_optimal.jpg dslr_nikon_d7200_1.guetzli.jpg
    Original Out[ 374902] BA[100.00%] D[0.0000] Score[374902.0000] (*)
    Iter  1: f112222 quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  1: f112222 GQ[183.43] Out[ 375029] BA[100.00%] D[0.0000] Score[375029.0000]
    Iter  2: f112222 quantization matrix:
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    Iter  2: f112222 GQ[ 0.00] Out[ 560481] BA[100.00%] D[0.0000] Score[560481.0000]
    Iter  3: f112222 quantization matrix:
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    Iter  3: f112222 GQ[22.56] Out[ 458291] BA[100.00%] D[0.6973] Score[458291.0000]
    Iter  4: f112222 quantization matrix:
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  4: f112222 GQ[45.11] Out[ 414054] BA[100.00%] D[2.0368] Score[384747462.3457]
    Iter  5: f112222 quantization matrix:
    3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5   
    3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5   
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  5: f112222 GQ[34.14] Out[ 439571] BA[100.00%] D[0.6721] Score[439571.0000]
    Iter  6: f112222 quantization matrix:
    3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  6: f112222 GQ[40.11] Out[ 423322] BA[100.00%] D[0.9357] Score[423322.0000]
    Iter  7: f112222 quantization matrix:
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  7: f112222 GQ[42.11] Out[ 418835] BA[100.00%] D[0.9647] Score[418835.0000]
    
    YUV420 selected quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  8: f112222(1) up Coeffs[191443/241597] Blocks[37494/40275/43776] ValThres[1.4251] Out[ 293676] EstErr[-0.04%] BA[100.00%] D[2.4321] Score[11717453674768301686839885577584640.0000]
    Iter  9: f112222(1) up Coeffs[22809/22809] Blocks[15555/15555/43776] ValThres[0.4750] Out[ 278361] EstErr[0.03%] BA[100.00%] D[2.5879] Score[15150108858268451221674068574994432.0000]
    Iter 10: f112222(1) down Coeffs[5134/185610] Blocks[4405/25669/43776] ValThres[0.0582] Out[ 281820] EstErr[0.02%] BA[100.00%] D[2.5879] Score[15148848493785868274537858198405120.0000]
    Iter 11: f112222(1) down Coeffs[4993/176774] Blocks[4302/24960/43776] ValThres[0.0585] Out[ 285058] EstErr[0.01%] BA[100.00%] D[2.5348] Score[13980868727776687428909045443985408.0000]
    Iter 12: f112222(1) down Coeffs[4613/159613] Blocks[3960/23060/43776] ValThres[0.0611] Out[ 288152] EstErr[0.04%] BA[100.00%] D[2.4193] Score[11435268570155439058762067752255488.0000]
    Iter 13: f112222(1) down Coeffs[3776/126920] Blocks[3239/18878/43776] ValThres[0.0674] Out[ 290410] EstErr[-0.02%] BA[100.00%] D[2.4061] Score[11145594799908567518525485647659008.0000]
    Iter 14: f112222(1) down Coeffs[2647/86169] Blocks[2268/13234/43776] ValThres[0.0711] Out[ 292042] EstErr[-0.03%] BA[100.00%] D[2.3027] Score[8868536301376225293639964117958656.0000]
    Iter 15: f112222(1) down Coeffs[1570/48746] Blocks[1354/7847/43776] ValThres[0.0769] Out[ 293041] EstErr[-0.04%] BA[100.00%] D[2.1331] Score[5132590159698635841252762241204224.0000]
    Iter 16: f112222(1) down Coeffs[701/20744] Blocks[589/3502/43776] ValThres[0.0671] Out[ 293500] EstErr[-0.02%] BA[100.00%] D[2.0302] Score[196044589.4827]
    Iter 17: f112222(1) down Coeffs[324/7217] Blocks[275/1375/43776] ValThres[0.1047] Out[ 293660] EstErr[-0.03%] BA[100.00%] D[1.9318] Score[1429279.7919]
    Iter 18: f112222(1) down Coeffs[328/1257] Blocks[206/277/43776] ValThres[0.6570] Out[ 293836] EstErr[-0.03%] BA[100.00%] D[1.8431] Score[293836.0000] (*)
    Iter 19: f112222(6) up Coeffs[28642/36308] Blocks[6460/7891/11008] ValThres[1.7250] Out[ 279190] EstErr[-0.02%] BA[100.00%] D[2.1698] Score[5939858862311389268245587351830528.0000]
    Iter 20: f112222(6) up Coeffs[4683/4683] Blocks[2728/2728/11008] ValThres[0.1751] Out[ 276199] EstErr[-0.01%] BA[100.00%] D[2.1698] Score[5939795844087259659720174990262272.0000]
    Iter 21: f112222(6) up Coeffs[2/2] Blocks[2/2/11008] ValThres[0.1071] Out[ 276191] EstErr[-0.01%] BA[100.00%] D[2.1698] Score[5939795844087259659720174990262272.0000]
    Iter 22: f112222(6) down Coeffs[4889/30151] Blocks[2583/6110/11008] ValThres[0.1506] Out[ 279459] EstErr[-0.02%] BA[100.00%] D[2.0630] Score[963669654.0659]
    Iter 23: f112222(6) down Coeffs[3744/21567] Blocks[2135/4679/11008] ValThres[0.1371] Out[ 281905] EstErr[-0.01%] BA[100.00%] D[2.0113] Score[73061261.6896]
    Iter 24: f112222(6) down Coeffs[2089/11676] Blocks[1232/2611/11008] ValThres[0.1186] Out[ 283183] EstErr[-0.03%] BA[100.00%] D[1.9791] Score[14672799.4110]
    Iter 25: f112222(6) down Coeffs[776/3863] Blocks[445/969/11008] ValThres[0.1134] Out[ 283698] EstErr[-0.01%] BA[100.00%] D[1.9465] Score[2890875.0211]
    Iter 26: f112222(6) down Coeffs[238/849] Blocks[138/253/11008] ValThres[0.1380] Out[ 283824] EstErr[-0.02%] BA[100.00%] D[1.9011] Score[297568.5602]
    Iter 27: f112222(6) down Coeffs[17/17] Blocks[6/6/11008] ValThres[1.1396] Out[ 283851] EstErr[-0.01%] BA[100.00%] D[1.9000] Score[283851.0000] (*)
    /opt/mozjpeg/bin/jpegtran -verbose -outfile dslr_nikon_d7200_1.mozjpeg.jpg dslr_nikon_d7200_1_optimal.jpg
    mozjpeg version 3.2 (build 20170428)
    Copyright (C) 2009-2016 D. R. Commander
    Copyright (C) 2011-2016 Siarhei Siamashka
    Copyright (C) 2015-2016 Matthieu Darbois
    Copyright (C) 2015 Google, Inc.
    Copyright (C) 2014 Mozilla Corporation
    Copyright (C) 2013-2014 MIPS Technologies, Inc.
    Copyright (C) 2013 Linaro Limited
    Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2009 Pierre Ossman for Cendio AB
    Copyright (C) 1999-2006 MIYASAKA Masaru
    Copyright (C) 1991-2016 Thomas G. Lane, Guido Vollbeding
    
    Emulating The Independent JPEG Group's software, version 6b  27-Mar-1998
    
    Start of Image
    JFIF APP0 marker: version 1.01, density 1x1  0
    Define Quantization Table 0  precision 0
    Define Quantization Table 1  precision 0
    Start Of Frame 0xc0: width=2048, height=1365, components=3
        Component 1: 2hx2v q=0
        Component 2: 1hx1v q=1
        Component 3: 1hx1v q=1
    Define Huffman Table 0x00
    Define Huffman Table 0x10
    Define Huffman Table 0x01
    Define Huffman Table 0x11
    Start Of Scan: 3 components
        Component 1: dc=0 ac=0
        Component 2: dc=1 ac=1
        Component 3: dc=1 ac=1
    Ss=0, Se=63, Ah=0, Al=0
    End Of Image
    SCAN 0: 0 0 0 0
    SCAN 1: 0 0 0 0
    SCAN 2: 0 0 0 0
    SCAN 0: 1 2 0 1
    SCAN 0: 3 63 0 1
    SCAN 0: 1 63 1 0
    SCAN 1: 1 2 0 0
    SCAN 1: 3 63 0 0
    SCAN 2: 1 2 0 0
    SCAN 2: 3 63 0 0
    ### webp-study-source-firebreathing.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-firebreathing.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2             -write mpr:webp-study-source-firebreathing -resize 2048x2048\> -write webp-study-source-firebreathing_optimal.png +delete             mpr:webp-study-source-firebreathing -define webp:thread-level=1 -    define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> webp-study-source-firebreathing.webp
    optipng -o2 webp-study-source-firebreathing_optimal.png -preserve -out webp-study-source-firebreathing.optipng.png
    ** Processing: webp-study-source-firebreathing_optimal.png
    1024x752 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 1199692 bytes
    Input file size = 1200202 bytes
    
    Trying:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 1194013
                                   
    Selecting parameters:
    zc = 9  zm = 8  zs = 1  f = 5         IDAT size = 1194013
    
    Output file: webp-study-source-firebreathing.optipng.png
    
    Output IDAT size = 1194013 bytes (5679 bytes decrease)
    Output file size = 1194091 bytes (6111 bytes = 0.51% decrease)
    
    zopflipng -y --iterations=1 webp-study-source-firebreathing_optimal.png webp-study-source-firebreathing.zopflipng.png
    Optimizing webp-study-source-firebreathing_optimal.png
    Input size: 1200202 (1172K)
    Result size: 1184812 (1157K). Percentage of original: 98.718%
    Result is smaller
    
    ### png24-interlaced-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-interlaced-image1.png -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2             -write mpr:png24-interlaced-image1 -resize 2048x2048\> -write png24-interlaced-image1_optimal.png +delete             mpr:png24-interlaced-image1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -   define webp:lossless=false -quality 75 -resize 2048x2048\> png24-interlaced-image1.webp
    optipng -o2 png24-interlaced-image1_optimal.png -preserve -out png24-interlaced-image1.optipng.png
    ** Processing: png24-interlaced-image1_optimal.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output file: png24-interlaced-image1.optipng.png
    
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    zopflipng -y --iterations=1 png24-interlaced-image1_optimal.png png24-interlaced-image1.zopflipng.png
    Optimizing png24-interlaced-image1_optimal.png
    Input size: 386195 (377K)
    Result size: 386473 (377K). Percentage of original: 100.072%
    Preserving original PNG since it was smaller
    
    ### dslr_nikon_d7200_2.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_2.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip             -write mpr:dslr_nikon_d7200_2 -resize 2048x2048\> -write dslr_nikon_d7200_2_optimal.jpg +delete             mpr:dslr_nikon_d7200_2 -define webp:thread-level=1 -define webp:method=4 -define   webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_nikon_d7200_2.webp
    jpegoptim -p --max=82 dslr_nikon_d7200_2_optimal.jpg
    dslr_nikon_d7200_2_optimal.jpg 1365x2048 24bit N JFIF  [OK] 620836 --> 516224 bytes (16.85%), optimized.
    /opt/guetzli/bin/Release/guetzli --quality 85 --verbose dslr_nikon_d7200_2_optimal.jpg dslr_nikon_d7200_2.guetzli.jpg
    Original Out[ 515687] BA[100.00%] D[0.0000] Score[515687.0000] (*)
    Iter  1: f112222 quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  1: f112222 GQ[183.43] Out[ 515687] BA[100.00%] D[0.0000] Score[515687.0000]
    Iter  2: f112222 quantization matrix:
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    Iter  2: f112222 GQ[ 0.00] Out[ 813852] BA[100.00%] D[0.0000] Score[813852.0000]
    Iter  3: f112222 quantization matrix:
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    Iter  3: f112222 GQ[22.56] Out[ 653385] BA[100.00%] D[0.6221] Score[653385.0000]
    Iter  4: f112222 quantization matrix:
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  4: f112222 GQ[45.11] Out[ 594750] BA[100.00%] D[1.6777] Score[594750.0000]
    Iter  5: f112222 quantization matrix:
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    Iter  5: f112222 GQ[67.67] Out[ 524046] BA[100.00%] D[3.0759] Score[25897578149963262551127143103856640.0000]
    Iter  6: f112222 quantization matrix:
    5  5  5  5  7  7  7  7     5  5  5  5  7  7  7  7     5  5  5  5  7  7  7  7   
    5  5  5  7  7  7  7  7     5  5  5  7  7  7  7  7     5  5  5  7  7  7  7  7   
    5  7  7  7  7  7  7  7     5  7  7  7  7  7  7  7     5  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    Iter  6: f112222 GQ[56.69] Out[ 553720] BA[100.00%] D[1.7060] Score[553720.0000]
    Iter  7: f112222 quantization matrix:
    5  5  7  7  7  7  7  7     5  5  7  7  7  7  7  7     5  5  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    Iter  7: f112222 GQ[62.67] Out[ 532017] BA[100.00%] D[1.7811] Score[532017.0000]
    Iter  8: f112222 quantization matrix:
    5  7  7  7  7  7  7  7     5  7  7  7  7  7  7  7     5  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7     7  7  7  7  7  7  7  7   
    Iter  8: f112222 GQ[64.67] Out[ 528015] BA[100.00%] D[1.8236] Score[528015.0000]
    
    YUV420 selected quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  9: f112222(1) up Coeffs[312307/403791] Blocks[41497/42386/43776] ValThres[1.4251] Out[ 406233] EstErr[0.05%] BA[100.00%] D[2.4908] Score[13010235782146533405289504711901184.0000]
    Iter 10: f112222(1) up Coeffs[21855/22968] Blocks[10672/10927/43776] ValThres[0.4504] Out[ 393543] EstErr[0.02%] BA[100.00%] D[2.5651] Score[14647732827029752772272193292730368.0000]
    Iter 11: f112222(1) up Coeffs[170/170] Blocks[170/170/43776] ValThres[0.0246] Out[ 393371] EstErr[0.01%] BA[100.00%] D[2.5651] Score[14647732827029752772272193292730368.0000]
    Iter 12: f112222(1) down Coeffs[7277/321846] Blocks[5971/36381/43776] ValThres[0.0386] Out[ 397807] EstErr[0.07%] BA[100.00%] D[2.5210] Score[13676779538760276889566570977689600.0000]
    Iter 13: f112222(1) down Coeffs[7184/311316] Blocks[5878/35916/43776] ValThres[0.0402] Out[ 401766] EstErr[0.06%] BA[100.00%] D[2.4792] Score[12755741935519744311350038540320768.0000]
    Iter 14: f112222(1) down Coeffs[6894/292872] Blocks[5687/34466/43776] ValThres[0.0421] Out[ 405603] EstErr[0.06%] BA[100.00%] D[2.4782] Score[12732425192591969012702183428194304.0000]
    Iter 15: f112222(1) down Coeffs[6238/259130] Blocks[5103/31186/43776] ValThres[0.0452] Out[ 408990] EstErr[0.05%] BA[100.00%] D[2.4595] Score[12322213314142113984990553728614400.0000]
    Iter 16: f112222(1) down Coeffs[5181/209098] Blocks[4223/25904/43776] ValThres[0.0478] Out[ 411777] EstErr[0.04%] BA[100.00%] D[2.4591] Score[12312765832041424921300032534085632.0000]
    Iter 17: f112222(1) down Coeffs[3826/149419] Blocks[3129/19126/43776] ValThres[0.0498] Out[ 413877] EstErr[0.04%] BA[100.00%] D[2.2436] Score[7566774097059592382687855264137216.0000]
    Iter 18: f112222(1) down Coeffs[2513/94791] Blocks[2065/12564/43776] ValThres[0.0521] Out[ 415189] EstErr[0.03%] BA[100.00%] D[2.2320] Score[7309607227425992954228980244807680.0000]
    Iter 19: f112222(1) down Coeffs[1528/55763] Blocks[1235/7638/43776] ValThres[0.0538] Out[ 416070] EstErr[0.03%] BA[100.00%] D[2.0412] Score[481162600.4206]
    Iter 20: f112222(1) down Coeffs[812/27775] Blocks[663/4058/43776] ValThres[0.0545] Out[ 416481] EstErr[0.03%] BA[100.00%] D[2.0018] Score[67131347.4081]
    Iter 21: f112222(1) down Coeffs[441/10342] Blocks[358/1694/43776] ValThres[0.0841] Out[ 416747] EstErr[0.03%] BA[100.00%] D[1.9134] Score[810517.6513]
    Iter 22: f112222(1) down Coeffs[453/1594] Blocks[254/342/43776] ValThres[0.6336] Out[ 417010] EstErr[0.03%] BA[100.00%] D[1.8430] Score[417010.0000] (*)
    Iter 23: f112222(6) up Coeffs[40180/41434] Blocks[8759/8938/11008] ValThres[1.8519] Out[ 396193] EstErr[0.04%] BA[100.00%] D[2.2271] Score[7201930088464030035755201030258688.0000]
    Iter 24: f112222(6) up Coeffs[493/493] Blocks[400/400/11008] ValThres[0.0481] Out[ 395877] EstErr[0.03%] BA[100.00%] D[2.2271] Score[7201930088464030035755201030258688.0000]
    Iter 25: f112222(6) down Coeffs[5874/36590] Blocks[3439/7342/11008] ValThres[0.2345] Out[ 399699] EstErr[0.04%] BA[100.00%] D[2.1169] Score[4774767431574792805908583901298688.0000]
    Iter 26: f112222(6) down Coeffs[4818/27102] Blocks[2829/6022/11008] ValThres[0.1707] Out[ 402523] EstErr[0.03%] BA[100.00%] D[2.0811] Score[3419008404.2126]
    Iter 27: f112222(6) down Coeffs[3197/16349] Blocks[1907/3996/11008] ValThres[0.1441] Out[ 404341] EstErr[0.04%] BA[100.00%] D[1.9676] Score[11817770.7203]
    Iter 28: f112222(6) down Coeffs[997/4608] Blocks[613/1245/11008] ValThres[0.1219] Out[ 404861] EstErr[0.03%] BA[100.00%] D[1.9470] Score[4230760.0632]
    Iter 29: f112222(6) down Coeffs[385/746] Blocks[167/217/11008] ValThres[0.3182] Out[ 405129] EstErr[0.05%] BA[100.00%] D[1.9000] Score[405129.0000] (*)
    /opt/mozjpeg/bin/jpegtran -verbose -outfile dslr_nikon_d7200_2.mozjpeg.jpg dslr_nikon_d7200_2_optimal.jpg
    mozjpeg version 3.2 (build 20170428)
    Copyright (C) 2009-2016 D. R. Commander
    Copyright (C) 2011-2016 Siarhei Siamashka
    Copyright (C) 2015-2016 Matthieu Darbois
    Copyright (C) 2015 Google, Inc.
    Copyright (C) 2014 Mozilla Corporation
    Copyright (C) 2013-2014 MIPS Technologies, Inc.
    Copyright (C) 2013 Linaro Limited
    Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2009 Pierre Ossman for Cendio AB
    Copyright (C) 1999-2006 MIYASAKA Masaru
    Copyright (C) 1991-2016 Thomas G. Lane, Guido Vollbeding
    
    Emulating The Independent JPEG Group's software, version 6b  27-Mar-1998
    
    Start of Image
    JFIF APP0 marker: version 1.01, density 1x1  0
    Define Quantization Table 0  precision 0
    Define Quantization Table 1  precision 0
    Start Of Frame 0xc0: width=1365, height=2048, components=3
        Component 1: 2hx2v q=0
        Component 2: 1hx1v q=1
        Component 3: 1hx1v q=1
    Define Huffman Table 0x00
    Define Huffman Table 0x10
    Define Huffman Table 0x01
    Define Huffman Table 0x11
    Start Of Scan: 3 components
        Component 1: dc=0 ac=0
        Component 2: dc=1 ac=1
        Component 3: dc=1 ac=1
    Ss=0, Se=63, Ah=0, Al=0
    End Of Image
    SCAN 0: 0 0 0 0
    SCAN 1: 0 0 0 0
    SCAN 2: 0 0 0 0
    SCAN 0: 1 5 0 1
    SCAN 0: 6 63 0 1
    SCAN 0: 1 63 1 0
    SCAN 1: 1 2 0 0
    SCAN 1: 3 63 0 0
    SCAN 2: 1 2 0 0
    SCAN 2: 3 63 0 0
    ### dslr_canon_eos_m6_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip             -write mpr:dslr_canon_eos_m6_1 -resize 2048x2048\> -write dslr_canon_eos_m6_1_optimal.jpg +delete             mpr:dslr_canon_eos_m6_1 -define webp:thread-level=1 -define webp:method=4 - define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> dslr_canon_eos_m6_1.webp
    jpegoptim -p --max=82 dslr_canon_eos_m6_1_optimal.jpg
    dslr_canon_eos_m6_1_optimal.jpg 1200x800 24bit N JFIF  [OK] 199260 --> 161086 bytes (19.16%), optimized.
    /opt/guetzli/bin/Release/guetzli --quality 85 --verbose dslr_canon_eos_m6_1_optimal.jpg dslr_canon_eos_m6_1.guetzli.jpg
    Original Out[ 161070] BA[100.00%] D[0.0000] Score[161070.0000] (*)
    Iter  1: f112222 quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  1: f112222 GQ[183.43] Out[ 161070] BA[100.00%] D[0.0000] Score[161070.0000]
    Iter  2: f112222 quantization matrix:
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    Iter  2: f112222 GQ[ 0.00] Out[ 247303] BA[100.00%] D[0.0000] Score[247303.0000]
    Iter  3: f112222 quantization matrix:
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    Iter  3: f112222 GQ[22.56] Out[ 200886] BA[100.00%] D[0.5143] Score[200886.0000]
    Iter  4: f112222 quantization matrix:
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  4: f112222 GQ[45.11] Out[ 184337] BA[100.00%] D[2.0057] Score[36154675.7314]
    Iter  5: f112222 quantization matrix:
    3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5   
    3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5   
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  5: f112222 GQ[34.14] Out[ 194965] BA[100.00%] D[0.5407] Score[194965.0000]
    Iter  6: f112222 quantization matrix:
    3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  6: f112222 GQ[40.11] Out[ 187873] BA[100.00%] D[0.7862] Score[187873.0000]
    Iter  7: f112222 quantization matrix:
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  7: f112222 GQ[42.11] Out[ 186164] BA[100.00%] D[0.7986] Score[186164.0000]
    
    YUV420 selected quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  8: f112222(1) up Coeffs[93501/116031] Blocks[14897/14931/15000] ValThres[1.4251] Out[ 121079] EstErr[0.04%] BA[100.00%] D[2.4742] Score[12645202718878583385702118000164864.0000]
    Iter  9: f112222(1) up Coeffs[14845/14845] Blocks[8402/8402/15000] ValThres[0.4750] Out[ 110904] EstErr[0.07%] BA[100.00%] D[2.7607] Score[18956519877559755106351440354869248.0000]
    Iter 10: f112222(1) down Coeffs[2623/101140] Blocks[2218/13110/15000] ValThres[0.0591] Out[ 112759] EstErr[0.03%] BA[100.00%] D[2.7088] Score[17812276975972545412311225647235072.0000]
    Iter 11: f112222(1) down Coeffs[2529/95846] Blocks[2175/12643/15000] ValThres[0.0635] Out[ 114541] EstErr[0.01%] BA[100.00%] D[2.6120] Score[15679330652986155377030780652879872.0000]
    Iter 12: f112222(1) down Coeffs[2349/87575] Blocks[2051/11741/15000] ValThres[0.0618] Out[ 116157] EstErr[0.00%] BA[100.00%] D[2.5664] Score[14675340060716985291147988988592128.0000]
    Iter 13: f112222(1) down Coeffs[2014/74238] Blocks[1723/10068/15000] ValThres[0.0670] Out[ 117531] EstErr[-0.01%] BA[100.00%] D[2.4002] Score[11016108103879248795732159120801792.0000]
    Iter 14: f112222(1) down Coeffs[1582/58202] Blocks[1323/7909/15000] ValThres[0.0634] Out[ 118599] EstErr[-0.02%] BA[100.00%] D[2.3746] Score[10450803124328943185514442092707840.0000]
    Iter 15: f112222(1) down Coeffs[1133/40972] Blocks[939/5661/15000] ValThres[0.0644] Out[ 119352] EstErr[-0.02%] BA[100.00%] D[2.1297] Score[5057057566561203244300082853445632.0000]
    Iter 16: f112222(1) down Coeffs[744/26380] Blocks[609/3715/15000] ValThres[0.0623] Out[ 119957] EstErr[0.07%] BA[100.00%] D[2.0126] Score[33176918.4122]
    Iter 17: f112222(1) down Coeffs[333/11445] Blocks[284/1664/15000] ValThres[0.0678] Out[ 120213] EstErr[0.10%] BA[100.00%] D[1.9256] Score[430903.1744]
    Iter 18: f112222(1) down Coeffs[124/3274] Blocks[109/500/15000] ValThres[0.0941] Out[ 120274] EstErr[0.08%] BA[100.00%] D[1.9155] Score[260095.9538]
    Iter 19: f112222(1) down Coeffs[136/935] Blocks[96/148/15000] ValThres[0.3812] Out[ 120397] EstErr[0.12%] BA[100.00%] D[1.8430] Score[120397.0000] (*)
    Iter 20: f112222(6) up Coeffs[12732/14342] Blocks[3057/3241/3750] ValThres[1.8247] Out[ 114364] EstErr[0.10%] BA[100.00%] D[2.3085] Score[8995349974398732528992377190219776.0000]
    Iter 21: f112222(6) up Coeffs[676/676] Blocks[480/480/3750] ValThres[0.0754] Out[ 113969] EstErr[0.12%] BA[100.00%] D[2.3085] Score[8995349974398732528992377190219776.0000]
    Iter 22: f112222(6) down Coeffs[2364/12759] Blocks[1496/2954/3750] ValThres[0.1389] Out[ 115349] EstErr[0.10%] BA[100.00%] D[2.2158] Score[6953890358291797811900765622501376.0000]
    Iter 23: f112222(6) down Coeffs[1765/9009] Blocks[1084/2205/3750] ValThres[0.1217] Out[ 116312] EstErr[0.12%] BA[100.00%] D[2.1513] Score[5533522604645476341809202717523968.0000]
    Iter 24: f112222(6) down Coeffs[1070/5546] Blocks[644/1337/3750] ValThres[0.1005] Out[ 116826] EstErr[0.09%] BA[100.00%] D[2.1321] Score[5110013880904377101710227039846400.0000]
    Iter 25: f112222(6) down Coeffs[569/2948] Blocks[336/710/3750] ValThres[0.0982] Out[ 117099] EstErr[0.10%] BA[100.00%] D[1.9612] Score[2487677.5430]
    Iter 26: f112222(6) down Coeffs[209/1067] Blocks[134/260/3750] ValThres[0.1031] Out[ 117209] EstErr[0.11%] BA[100.00%] D[1.9612] Score[2488234.0475]
    Iter 27: f112222(6) down Coeffs[116/310] Blocks[53/69/3750] ValThres[0.1695] Out[ 117227] EstErr[0.08%] BA[100.00%] D[1.8997] Score[117227.0000] (*)
    /opt/mozjpeg/bin/jpegtran -verbose -outfile dslr_canon_eos_m6_1.mozjpeg.jpg dslr_canon_eos_m6_1_optimal.jpg
    mozjpeg version 3.2 (build 20170428)
    Copyright (C) 2009-2016 D. R. Commander
    Copyright (C) 2011-2016 Siarhei Siamashka
    Copyright (C) 2015-2016 Matthieu Darbois
    Copyright (C) 2015 Google, Inc.
    Copyright (C) 2014 Mozilla Corporation
    Copyright (C) 2013-2014 MIPS Technologies, Inc.
    Copyright (C) 2013 Linaro Limited
    Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2009 Pierre Ossman for Cendio AB
    Copyright (C) 1999-2006 MIYASAKA Masaru
    Copyright (C) 1991-2016 Thomas G. Lane, Guido Vollbeding
    
    Emulating The Independent JPEG Group's software, version 6b  27-Mar-1998
    
    Start of Image
    JFIF APP0 marker: version 1.01, density 1x1  0
    Define Quantization Table 0  precision 0
    Define Quantization Table 1  precision 0
    Start Of Frame 0xc0: width=1200, height=800, components=3
        Component 1: 2hx2v q=0
        Component 2: 1hx1v q=1
        Component 3: 1hx1v q=1
    Define Huffman Table 0x00
    Define Huffman Table 0x10
    Define Huffman Table 0x01
    Define Huffman Table 0x11
    Start Of Scan: 3 components
        Component 1: dc=0 ac=0
        Component 2: dc=1 ac=1
        Component 3: dc=1 ac=1
    Ss=0, Se=63, Ah=0, Al=0
    End Of Image
    SCAN 0: 0 0 0 0
    SCAN 1: 0 0 0 0
    SCAN 2: 0 0 0 0
    SCAN 0: 1 2 0 1
    SCAN 0: 3 63 0 1
    SCAN 1: 1 2 0 1
    SCAN 1: 3 63 0 1
    SCAN 2: 1 2 0 1
    SCAN 2: 3 63 0 1
    SCAN 0: 1 63 1 0
    SCAN 1: 1 63 1 0
    SCAN 2: 1 63 1 0
    ### png24-image1.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-image1.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2             -write mpr:png24-image1 -resize 2048x2048\> -write png24-image1_optimal.png +delete             mpr:png24-image1 -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality    75 -resize 2048x2048\> png24-image1.webp
    optipng -o2 png24-image1_optimal.png -preserve -out png24-image1.optipng.png
    ** Processing: png24-image1_optimal.png
    600x400 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 386006 bytes
    Input file size = 386195 bytes
    
    Trying:
                                   
    Output file: png24-image1.optipng.png
    
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386063 bytes (132 bytes = 0.03% decrease)
    
    zopflipng -y --iterations=1 png24-image1_optimal.png png24-image1.zopflipng.png
    Optimizing png24-image1_optimal.png
    Input size: 386195 (377K)
    Result size: 386473 (377K). Percentage of original: 100.072%
    Preserving original PNG since it was smaller
    
    ### samsung_s7_mobile_1.jpg (jpg) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp samsung_s7_mobile_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip             -write mpr:samsung_s7_mobile_1 -resize 2048x2048\> -write samsung_s7_mobile_1_optimal.jpg +delete             mpr:samsung_s7_mobile_1 -define webp:thread-level=1 -define webp:method=4 - define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\> samsung_s7_mobile_1.webp
    jpegoptim -p --max=82 samsung_s7_mobile_1_optimal.jpg
    samsung_s7_mobile_1_optimal.jpg 2048x1536 24bit N JFIF  [OK] 437104 --> 256253 bytes (41.37%), optimized.
    /opt/guetzli/bin/Release/guetzli --quality 85 --verbose samsung_s7_mobile_1_optimal.jpg samsung_s7_mobile_1.guetzli.jpg
    Original Out[ 256192] BA[100.00%] D[0.0000] Score[256192.0000] (*)
    Iter  1: f112222 quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  1: f112222 GQ[183.43] Out[ 256192] BA[100.00%] D[0.0000] Score[256192.0000]
    Iter  2: f112222 quantization matrix:
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1     1  1  1  1  1  1  1  1   
    Iter  2: f112222 GQ[ 0.00] Out[ 356117] BA[100.00%] D[0.0000] Score[356117.0000]
    Iter  3: f112222 quantization matrix:
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3     3  3  3  3  3  3  3  3   
    Iter  3: f112222 GQ[22.56] Out[ 296032] BA[100.00%] D[0.6605] Score[296032.0000]
    Iter  4: f112222 quantization matrix:
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  4: f112222 GQ[45.11] Out[ 267579] BA[100.00%] D[2.1324] Score[5117108682637580572271182486700032.0000]
    Iter  5: f112222 quantization matrix:
    3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5     3  3  3  3  5  5  5  5   
    3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5     3  3  3  5  5  5  5  5   
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  5: f112222 GQ[34.14] Out[ 290036] BA[100.00%] D[0.6830] Score[290036.0000]
    Iter  6: f112222 quantization matrix:
    3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5     3  3  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  6: f112222 GQ[40.11] Out[ 275577] BA[100.00%] D[0.9650] Score[275577.0000]
    Iter  7: f112222 quantization matrix:
    3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5     3  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5     5  5  5  5  5  5  5  5   
    Iter  7: f112222 GQ[42.11] Out[ 272095] BA[100.00%] D[0.9673] Score[272095.0000]
    
    YUV420 selected quantization matrix:
    6  4  4  6  9 14 18 22     6  6  9 17 36 36 36 36     6  6  9 17 36 36 36 36   
    4  4  5  7  9 21 22 20     6  8  9 24 36 36 36 36     6  8  9 24 36 36 36 36   
    5  5  6  9 14 21 25 20     9  9 20 36 36 36 36 36     9  9 20 36 36 36 36 36   
    5  6  8 10 18 31 29 22    17 24 36 36 36 36 36 36    17 24 36 36 36 36 36 36   
    6  8 13 20 24 39 37 28    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    9 13 20 23 29 37 41 33    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    18 23 28 31 37 44 43 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    26 33 34 35 40 36 37 36    36 36 36 36 36 36 36 36    36 36 36 36 36 36 36 36   
    Iter  8: f112222(1) up Coeffs[124231/153862] Blocks[43536/45602/49152] ValThres[1.4251] Out[ 189354] EstErr[0.07%] BA[100.00%] D[2.3307] Score[9483279077755828327947158536847360.0000]
    Iter  9: f112222(1) up Coeffs[26844/26844] Blocks[22542/22542/49152] ValThres[0.4750] Out[ 170233] EstErr[0.06%] BA[100.00%] D[2.6776] Score[17124669377943641110964970182410240.0000]
    Iter 10: f112222(1) down Coeffs[3399/76130] Blocks[3125/16994/49152] ValThres[0.1362] Out[ 172668] EstErr[0.03%] BA[100.00%] D[2.4560] Score[12244396310380001525735749943558144.0000]
    Iter 11: f112222(1) down Coeffs[2685/59041] Blocks[2455/13420/49152] ValThres[0.1323] Out[ 174588] EstErr[0.04%] BA[100.00%] D[2.3088] Score[9001678054405032487869592444600320.0000]
    Iter 12: f112222(1) down Coeffs[1728/37198] Blocks[1587/8639/49152] ValThres[0.1233] Out[ 175743] EstErr[0.01%] BA[100.00%] D[2.1450] Score[5393249289252724173993131471011840.0000]
    Iter 13: f112222(1) down Coeffs[783/16710] Blocks[726/3911/49152] ValThres[0.1181] Out[ 176329] EstErr[0.03%] BA[100.00%] D[1.9273] Score[684995.4796]
    Iter 14: f112222(1) down Coeffs[217/4497] Blocks[198/1084/49152] ValThres[0.1311] Out[ 176491] EstErr[0.03%] BA[100.00%] D[1.9205] Score[487942.0501]
    Iter 15: f112222(1) down Coeffs[193/1009] Blocks[144/252/49152] ValThres[0.4310] Out[ 176647] EstErr[0.04%] BA[100.00%] D[1.8429] Score[176647.0000] (*)
    Iter 16: f112222(6) up Coeffs[15017/15017] Blocks[6201/6201/12288] ValThres[1.9001] Out[ 168342] EstErr[0.05%] BA[100.00%] D[2.2574] Score[7869450627551774381725626652426240.0000]
    Iter 17: f112222(6) down Coeffs[2488/9718] Blocks[1598/3109/12288] ValThres[0.1795] Out[ 169827] EstErr[0.03%] BA[100.00%] D[2.2425] Score[7540847349349135205124499058982912.0000]
    Iter 18: f112222(6) down Coeffs[1373/5107] Blocks[869/1716/12288] ValThres[0.1397] Out[ 170656] EstErr[0.06%] BA[100.00%] D[2.0597] Score[497971328.8353]
    Iter 19: f112222(6) down Coeffs[572/2160] Blocks[374/714/12288] ValThres[0.1216] Out[ 170980] EstErr[0.07%] BA[100.00%] D[2.0198] Score[68029363.6661]
    Iter 20: f112222(6) down Coeffs[187/713] Blocks[123/233/12288] ValThres[0.1134] Out[ 171029] EstErr[0.05%] BA[100.00%] D[1.9927] Score[17563618.4583]
    Iter 21: f112222(6) down Coeffs[156/156] Blocks[52/52/12288] ValThres[1.0044] Out[ 171110] EstErr[0.05%] BA[100.00%] D[1.9001] Score[171110.0000] (*)
    /opt/mozjpeg/bin/jpegtran -verbose -outfile samsung_s7_mobile_1.mozjpeg.jpg samsung_s7_mobile_1_optimal.jpg
    mozjpeg version 3.2 (build 20170428)
    Copyright (C) 2009-2016 D. R. Commander
    Copyright (C) 2011-2016 Siarhei Siamashka
    Copyright (C) 2015-2016 Matthieu Darbois
    Copyright (C) 2015 Google, Inc.
    Copyright (C) 2014 Mozilla Corporation
    Copyright (C) 2013-2014 MIPS Technologies, Inc.
    Copyright (C) 2013 Linaro Limited
    Copyright (C) 2009-2011 Nokia Corporation and/or its subsidiary(-ies)
    Copyright (C) 2009 Pierre Ossman for Cendio AB
    Copyright (C) 1999-2006 MIYASAKA Masaru
    Copyright (C) 1991-2016 Thomas G. Lane, Guido Vollbeding
    
    Emulating The Independent JPEG Group's software, version 6b  27-Mar-1998
    
    Start of Image
    JFIF APP0 marker: version 1.01, density 1x1  0
    Define Quantization Table 0  precision 0
    Define Quantization Table 1  precision 0
    Start Of Frame 0xc0: width=2048, height=1536, components=3
        Component 1: 2hx2v q=0
        Component 2: 1hx1v q=1
        Component 3: 1hx1v q=1
    Define Huffman Table 0x00
    Define Huffman Table 0x10
    Define Huffman Table 0x01
    Define Huffman Table 0x11
    Start Of Scan: 3 components
        Component 1: dc=0 ac=0
        Component 2: dc=1 ac=1
        Component 3: dc=1 ac=1
    Ss=0, Se=63, Ah=0, Al=0
    End Of Image
    SCAN 0: 0 0 0 0
    SCAN 1: 0 0 0 0
    SCAN 2: 0 0 0 0
    SCAN 0: 1 2 0 1
    SCAN 0: 3 63 0 1
    SCAN 0: 1 63 1 0
    SCAN 1: 1 2 0 0
    SCAN 1: 3 63 0 0
    SCAN 2: 1 2 0 0
    SCAN 2: 3 63 0 0
    ### bees.png (png) ###
    /usr/bin/convert -define registry:temporary-path=/home/imagicktmp bees.png -interlace none -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=2             -write mpr:bees -resize 2048x2048\> -write bees_optimal.png +delete             mpr:bees -define webp:thread-level=1 -define webp:method=4 -define webp:alpha-quality=100 -define webp:lossless=false -quality 75 -resize 2048x2048\>     bees.webp
    optipng -o2 bees_optimal.png -preserve -out bees.optipng.png
    ** Processing: bees_optimal.png
    444x258 pixels, 3x8 bits/pixel, RGB
    Input IDAT size = 175199 bytes
    Input file size = 175356 bytes
    
    Trying:
                                   
    Output file: bees.optipng.png
    
    Output IDAT size = 175199 bytes (no change)
    Output file size = 175296 bytes (60 bytes = 0.03% decrease)
    
    zopflipng -y --iterations=1 bees_optimal.png bees.zopflipng.png
    Optimizing bees_optimal.png
    Input size: 175356 (171K)
    Result size: 177811 (173K). Percentage of original: 101.400%
    Preserving original PNG since it was smaller
    
    ------------------------------------------------------------------------------
    Completion Time: 376.42 seconds
    ------------------------------------------------------------------------------

Then at end will show the profile results after resize + optimisation including breakdown for each compressor where

* Original or Existing Images: is the profile for all orginal jpg + png images
* Optimised PNG Images (optipng): is the profile for just optimised png images optimised via optipng
* Optimised PNG Images (zopflipng): is the profile for just optimised png images optimised via zopflipng
* Optimised Images: is the profile for all optimised jpg + png original images
* Optimised WebP Images: is the profile for just optimised jpg + png images optimally converted to webp format
* Optimised Jpg Images (jpegoptim): is the profile for just optimised jpg images optimised via jpegoptim
* Optimised Jpg Images (guetzli): is the profile for just optimised jpg images optimised via guetzli
* Optimised Jpg Images (mozjpeg): is the profile for just optimised jpg images optimised via mozjpeg


output

    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-290417-103825.log
    ------------------------------------------------------------------------------
    image : bees_optimal.png : 444 : 258 : 92 : False : 8 : 175356 : root : root
    image : bees.optipng.png : 444 : 258 : 92 : False : 8 : 175296 : root : root
    image : bees.png : 444 : 258 : 92 : False : 8 : 177424 : root : root
    image : bees.webp : 444 : 258 : 92 : False : 8 : 10520 : root : root
    image : bees.zopflipng.png : 444 : 258 : 92 : False : 8 : 175356 : root : root
    image : dslr_canon_eos_m6_1.guetzli.jpg : 1200 : 800 : 82 : False : 8 : 117227 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root
    image : dslr_canon_eos_m6_1.mozjpeg.jpg : 1200 : 800 : 82 : False : 8 : 151142 : root : root
    image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : root
    image : dslr_canon_eos_m6_1.webp : 1200 : 800 : 92 : False : 8 : 61544 : root : root
    image : dslr_nikon_d7200_1.guetzli.jpg : 2048 : 1365 : 82 : False : 8 : 283851 : root : root
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root
    image : dslr_nikon_d7200_1.mozjpeg.jpg : 2048 : 1365 : 82 : False : 8 : 358638 : root : root
    image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : root
    image : dslr_nikon_d7200_1.webp : 2048 : 1365 : 92 : False : 8 : 173414 : root : root
    image : dslr_nikon_d7200_2.guetzli.jpg : 1365 : 2048 : 82 : False : 8 : 405129 : root : root
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root
    image : dslr_nikon_d7200_2.mozjpeg.jpg : 1365 : 2048 : 82 : False : 8 : 482841 : root : root
    image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : root
    image : dslr_nikon_d7200_2.webp : 1365 : 2048 : 92 : False : 8 : 212754 : root : root
    image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386195 : root : root
    image : png24-image1.optipng.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root
    image : png24-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : root
    image : png24-image1.zopflipng.png : 600 : 400 : 92 : False : 8 : 386195 : root : root
    image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386195 : root : root
    image : png24-interlaced-image1.optipng.png : 600 : 400 : 92 : False : 8 : 386063 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root
    image : png24-interlaced-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : root
    image : png24-interlaced-image1.zopflipng.png : 600 : 400 : 92 : False : 8 : 386195 : root : root
    image : samsung_s7_mobile_1.guetzli.jpg : 2048 : 1536 : 82 : False : 8 : 171110 : root : root
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root
    image : samsung_s7_mobile_1.mozjpeg.jpg : 2048 : 1536 : 82 : False : 8 : 246583 : root : root
    image : samsung_s7_mobile_1_optimal.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : root
    image : samsung_s7_mobile_1.webp : 2048 : 1536 : 92 : False : 8 : 69490 : root : root
    image : webp-study-source-firebreathing_optimal.png : 1024 : 752 : 92 : False : 8 : 1200202 : root : root
    image : webp-study-source-firebreathing.optipng.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root
    image : webp-study-source-firebreathing.webp : 1024 : 752 : 92 : False : 8 : 71860 : root : root
    image : webp-study-source-firebreathing.zopflipng.png : 1024 : 752 : 92 : False : 8 : 1184812 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1523      | 1281       | 89          | 1072767    | 25746417           | 25143           |
    
    ------------------------------------------------------------------------------
    Optimised PNG Images (optipng):
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 667       | 452        | 92          | 535378     | 2141513            | 2091            |
    
    ------------------------------------------------------------------------------
    Optimised PNG Images (zopflipng):
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 667       | 452        | 92          | 533140     | 2132558            | 2083            |
    
    ------------------------------------------------------------------------------
    Optimised Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 87          | 432058     | 3456465            | 3375            |
    
    ------------------------------------------------------------------------------
    Optimised WebP Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 92          | 81724      | 653790             | 638             |
    
    ------------------------------------------------------------------------------
    Optimised Jpg Images (jpegoptim):
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1665      | 1437       | 82          | 327129     | 1308517            | 1278            |
    
    ------------------------------------------------------------------------------
    Optimised Jpg Images (guetzli):
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1665      | 1437       | 82          | 244329     | 977317             | 954             |
    
    ------------------------------------------------------------------------------
    Optimised Jpg Images (mozjpeg):
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1665      | 1437       | 82          | 309801     | 1239204            | 1210            |
    
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
    Completion Time: 1.08 seconds
    ------------------------------------------------------------------------------

And the total benchmark completion time

    ------------------------------------------------------------------------------
    Benchmarked Completeion Time: 382.46 seconds
    ------------------------------------------------------------------------------

Interestingly, MozJPEG via jpegtran seems to convert jpgs to progressive jpgs with Interlace = JPEG reported when I enable `PROFILE_EXTEND='y'` to report additional image information like transparency color, background color and interlaced value. And for `png24-interlaced-image1.png` original image, all the resized and optimised copies lost their interlace value = None. So will need to tweak my script.

    /root/tools/optimise-images/optimise-images.sh profile /home/optimise-benchmarks/

    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group : transparency color : background color : interlaced
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks/
    logged at /home/optimise-logs/profile-log-290417-143720.log
    ------------------------------------------------------------------------------
    image : bees_optimal.png : 444 : 258 : 92 : False : 8 : 175356 : root : root : black : white : None
    image : bees.optipng.png : 444 : 258 : 92 : False : 8 : 175296 : root : root : black : white : None
    image : bees.png : 444 : 258 : 92 : False : 8 : 177424 : root : root : black : white : None
    image : bees.zopflipng.png : 444 : 258 : 92 : False : 8 : 175356 : root : root : black : white : None
    image : dslr_canon_eos_m6_1.guetzli.jpg : 1200 : 800 : 82 : False : 8 : 117227 : root : root : black : white : None
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : root : black : white : None
    image : dslr_canon_eos_m6_1.mozjpeg.jpg : 1200 : 800 : 82 : False : 8 : 151142 : root : root : black : white : JPEG
    image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : root : black : white : None
    image : dslr_nikon_d7200_1.guetzli.jpg : 2048 : 1365 : 82 : False : 8 : 283851 : root : root : black : white : None
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : root : black : white : None
    image : dslr_nikon_d7200_1.mozjpeg.jpg : 2048 : 1365 : 82 : False : 8 : 358638 : root : root : black : white : JPEG
    image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : root : black : white : None
    image : dslr_nikon_d7200_2.guetzli.jpg : 1365 : 2048 : 82 : False : 8 : 405129 : root : root : black : white : None
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : root : black : white : None
    image : dslr_nikon_d7200_2.mozjpeg.jpg : 1365 : 2048 : 82 : False : 8 : 482841 : root : root : black : white : JPEG
    image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : root : black : white : None
    image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386195 : root : root : black : white : None
    image : png24-image1.optipng.png : 600 : 400 : 92 : False : 8 : 386063 : root : root : black : white : None
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : root : black : white : None
    image : png24-image1.zopflipng.png : 600 : 400 : 92 : False : 8 : 386195 : root : root : black : white : None
    image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386195 : root : root : black : white : None
    image : png24-interlaced-image1.optipng.png : 600 : 400 : 92 : False : 8 : 386063 : root : root : black : white : None
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : root : black : white : PNG
    image : png24-interlaced-image1.zopflipng.png : 600 : 400 : 92 : False : 8 : 386195 : root : root : black : white : None
    image : samsung_s7_mobile_1.guetzli.jpg : 2048 : 1536 : 82 : False : 8 : 171110 : root : root : black : white : None
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : root : black : white : None
    image : samsung_s7_mobile_1.mozjpeg.jpg : 2048 : 1536 : 82 : False : 8 : 246583 : root : root : black : white : JPEG
    image : samsung_s7_mobile_1_optimal.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : root : black : white : None
    image : webp-study-source-firebreathing_optimal.png : 1024 : 752 : 92 : False : 8 : 1200202 : root : root : black : white : None
    image : webp-study-source-firebreathing.optipng.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : root : black : white : None
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : root : black : white : None
    image : webp-study-source-firebreathing.zopflipng.png : 1024 : 752 : 92 : False : 8 : 1184812 : root : root : black : white : None
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1523      | 1281       | 89          | 1072767    | 25746417           | 25143           |
    
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
    Completion Time: 19.01 seconds
    ------------------------------------------------------------------------------

### Summary

| State  | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
|---| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| Original JPG + PNG Images | 1523      | 1281       | 89          | 1072767    | 25746417           | 25143           |
| Default Resized + JpegOptim + OptinPNG   | 1166      | 945        | 87          | 432058     | 3456465            | 3375            |
| Resized + WebP Converted   | 1166      | 945        | 92          | 81724      | 653790             | 638             |


For JPG Only

| State  | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
|---| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| JpegOptim | 1665      | 1437       | 82          | 327129     | 1308517            | 1278            |
| Guetzli   | 1665      | 1437       | 82          | 244329     | 977317             | 954             |
| MozJPEG | 1665      | 1437       | 82          | 309801     | 1239204            | 1210            |

For PNG Only

| State  | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
|---| --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
| OptiPNG | 667       | 452        | 92          | 535378     | 2141513            | 2091            |
| ZopfliPNG   | 667       | 452        | 92          | 533140     | 2132558            | 2083            |


Side by Side compare

* Original image = 10.31 MB
* WebP = 169.35 KB
* MozJPEG = 350.23 KB
* Guetzli = 277.20 KB
* OptiPNG = 366.17 KB

![](/examples/benchmark-mode-compare-compressors1-290417/compare-dslr-nikon-d7200-1.jpg)

