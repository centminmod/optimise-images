Using [optimise-images.sh](https://github.com/centminmod/optimise-images) with new optional variable `ADD_COMMENT='n'`. When optional add comment variable is enabled `ADD_COMMENT='y'`, the script's ImageMagick routine will add to optimised images a comment = `optimised` marking optimised images. This will allow subsequent re-runs of script to detect the comment = `optimised` and skip re-optimising of the previously optimised image and only optimise unoptimised images. This will speed up the optimisation process on re-runs.

Usage:

```
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
```

`optimise` run at `/home/optimise-benchmarks` with `ADD_COMMENT='y'` set which adds a comment = `optimised` marking optimised images using `convert` command option `-set comment optimised`

    ./optimise-images.sh optimise /home/optimise-benchmarks 
       
    ------------------------------------------------------------------------------
    image optimisation start
    ------------------------------------------------------------------------------
    ### dslr_nikon_d7200_1.jpg (jpg) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-  upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_nikon_d7200_1.jpg
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_nikon_d7200_1.jpg
    dslr_nikon_d7200_1.jpg 2048x1365 24bit N JFIF  [OK] 1238116 --> 374967 bytes (69.71%), optimized.
    ### webp-study-source-firebreathing.png (png) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp webp-study-source-firebreathing.png -interlace none -set comment optimised -define png:compression-filter=5 -define   png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> webp-study-source-firebreathing.png
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 webp-study-source-firebreathing.png -preserve -out webp-study-source-firebreathing.png
    Output IDAT size = 1194013 bytes (5679 bytes decrease)
    Output file size = 1212920 bytes (6111 bytes = 0.50% decrease)
    ### png24-interlaced-image1.png (png) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-interlaced-image1.png -interlace plane -set comment optimised -define png:compression-filter=5 -define  png:compression-level=9 -define png:compression-strategy=2 -resize 2048x2048\> png24-interlaced-image1.png
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 png24-interlaced-image1.png -preserve -out png24-interlaced-image1.png
    Output IDAT size = 443874 bytes (2304 bytes decrease)
    Output file size = 444173 bytes (2460 bytes = 0.55% decrease)
    ### dslr_nikon_d7200_2.jpg (jpg) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_nikon_d7200_2.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy-  upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_nikon_d7200_2.jpg
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_nikon_d7200_2.jpg
    dslr_nikon_d7200_2.jpg 1365x2048 24bit N JFIF  [OK] 620849 --> 516237 bytes (16.85%), optimized.
    ### dslr_canon_eos_m6_1.jpg (jpg) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp dslr_canon_eos_m6_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy- upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> dslr_canon_eos_m6_1.jpg
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 dslr_canon_eos_m6_1.jpg
    dslr_canon_eos_m6_1.jpg 1200x800 24bit N JFIF  [OK] 199273 --> 161099 bytes (19.16%), optimized.
    ### png24-image1.png (png) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp png24-image1.png -interlace none -set comment optimised -define png:compression-filter=5 -define png:compression- level=9 -define png:compression-strategy=2 -resize 2048x2048\> png24-image1.png
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 png24-image1.png -preserve -out png24-image1.png
    Output IDAT size = 386006 bytes (no change)
    Output file size = 386305 bytes (132 bytes = 0.03% decrease)
    ### samsung_s7_mobile_1.jpg (jpg) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp samsung_s7_mobile_1.jpg -define jpeg:size=4096x4096 -filter triangle -define filter:support=2 -define jpeg:fancy- upsampling=off -unsharp 0.25x0.08+8.3+0.045 -interlace none -strip -set comment optimised -resize 2048x2048\> samsung_s7_mobile_1.jpg
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 jpegoptim -p --max=82 samsung_s7_mobile_1.jpg
    samsung_s7_mobile_1.jpg 2048x1536 24bit N JFIF  [OK] 437117 --> 256266 bytes (41.37%), optimized.
    ### bees.png (png) ###
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 /usr/bin/convert -define registry:temporary-path=/home/imagicktmp bees.png -interlace none -set comment optimised -define png:compression-filter=5 -define png:compression-level=9 -    define png:compression-strategy=2 -resize 2048x2048\> bees.png
    /bin/nice -n 10 /usr/bin/ionice -c2 -n7 optipng -o2 bees.png -preserve -out bees.png
    Output IDAT size = 175199 bytes (no change)
    Output file size = 175501 bytes (60 bytes = 0.03% decrease)
    ------------------------------------------------------------------------------
    Completion Time: 19.04 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image profile 
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-180817-102339.log
    ------------------------------------------------------------------------------
    image : bees.png : 444 : 258 : 92 : False : 8 : 175501 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161099 : root : root
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 374967 : root : root
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 516237 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386305 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 444173 : root : root
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256266 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1212920 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 87          | 440934     | 3527468            | 3445            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.9-7 Q16 x86_64 2017-08-13
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
    Completion Time: 0.14 seconds
    ------------------------------------------------------------------------------

`optimise` re-run at `/home/optimise-benchmarks` with `ADD_COMMENT='y'` set will result in previously optimised images being skipped when the previously embedded comment = `optimised` is detected

    ./optimise-images.sh optimise /home/optimise-benchmarks
    
    ------------------------------------------------------------------------------
    image optimisation start
    ------------------------------------------------------------------------------
    ### dslr_nikon_d7200_1.jpg (jpg) skip already optimised ###
    ### webp-study-source-firebreathing.png (png) skip already optimised ###
    ### png24-interlaced-image1.png (png) skip already optimised ###
    ### dslr_nikon_d7200_2.jpg (jpg) skip already optimised ###
    ### dslr_canon_eos_m6_1.jpg (jpg) skip already optimised ###
    ### png24-image1.png (png) skip already optimised ###
    ### samsung_s7_mobile_1.jpg (jpg) skip already optimised ###
    ### bees.png (png) skip already optimised ###
    ------------------------------------------------------------------------------
    Completion Time: 2.55 seconds
    ------------------------------------------------------------------------------
    
    ------------------------------------------------------------------------------
    image profile 
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/optimise-benchmarks
    logged at /home/optimise-logs/profile-log-180817-102713.log
    ------------------------------------------------------------------------------
    image : bees.png : 444 : 258 : 92 : False : 8 : 175501 : root : root
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161099 : root : root
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 374967 : root : root
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 516237 : root : root
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386305 : root : root
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 444173 : root : root
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256266 : root : root
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1212920 : root : root
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 87          | 440934     | 3527468            | 3445            |
    
    ------------------------------------------------------------------------------
    ImageMagick Resource Limits
    ------------------------------------------------------------------------------
    Version: ImageMagick 6.9.9-7 Q16 x86_64 2017-08-13
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
    Completion Time: 0.15 seconds
    ------------------------------------------------------------------------------