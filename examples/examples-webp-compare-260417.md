Using [optimise-images.sh](https://github.com/centminmod/optimise-images) to batch optimise and profile a directory of images creating both jpg/png copy + webp copy + enable [COMPARE_MODE](/examples/compare_mode-250417.md). For more info on [WebP](https://developers.google.com/speed/webp/)


Original Image Profile for images at `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 6000 : 4000 : 98 : False : 8 : 7486415 : root : nginx
    image : dslr_canon_eos_77d_2.jpg : 6000 : 4000 : 98 : False : 8 : 8316182 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : nginx
    image : dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : nginx
    image : dslr_hasselblad_x1d_1.jpg : 8272 : 6200 : 92 : False : 8 : 8780571 : root : nginx
    image : dslr_hasselblad_x1d_2.jpg : 8272 : 6200 : 92 : False : 8 : 13022968 : root : nginx
    image : dslr_leica_m10_1.jpg : 5976 : 3984 : 94 : False : 8 : 9268289 : root : nginx
    image : dslr_leica_m10_2.jpg : 5976 : 3984 : 94 : False : 8 : 7438563 : root : nginx
    image : dslr_nikon_d5_1.jpg : 5568 : 3712 : 99 : False : 8 : 10454579 : root : nginx
    image : dslr_nikon_d5_2.jpg : 5568 : 3712 : 99 : False : 8 : 17263077 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : nginx
    image : dslr_sony_alpha_a99_ii_1.jpg : 7952 : 5304 : 96 : False : 8 : 12444045 : root : nginx
    image : dslr_sony_alpha_a99_ii_2.jpg : 7952 : 5304 : 96 : False : 8 : 25899693 : root : nginx
    image : image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : nginx
    image : image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : nginx
    image : image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : nginx
    image : image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : nginx
    image : image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : nginx
    image : lenna.png : 512 : 512 : 92 : False : 8 : 473831 : root : nginx
    image : mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : nginx
    image : mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : nginx
    image : mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : nginx
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : nginx
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : nginx
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : nginx
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : nginx
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : nginx
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 101911 : root : nginx
    
    ------------------------------------------------------------------------------
    Original Images:
    ------------------------------------------------------------------------------
    | avg width | avg height | avg quality | avg size   | total size (Bytes) | total size (KB) |
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
    Completion Time: 8.08 seconds
    ------------------------------------------------------------------------------

`IMAGICK_WEBP` variable controls whether to create the webp copy and `IMAGICK_WEBPLOSSLES` controls whether webp copy is lossless or glossy. It defaults to `IMAGICK_WEBP='n'` and `IMAGICK_WEBPLOSSLESS='n'` and `COMPARE_MODE='n'` so you need to change the default settings

from

    IMAGICK_WEBP='n'
    IMAGICK_WEBPQUALITY='75'
    IMAGICK_WEBPMETHOD='4'
    IMAGICK_WEBPLOSSLESS='n'

    # comparison mode when enabled will when resizing and optimising images
    # write to a separate optimised image within the same directory as the
    # original images but with a suffix attached to the end of original image
    # file name i.e. image.png vs image_optimal.png
    COMPARE_MODE='n'
    COMPARE_SUFFIX='_optimal'

to

    IMAGICK_WEBP='y'
    IMAGICK_WEBPQUALITY='75'
    IMAGICK_WEBPMETHOD='4'
    IMAGICK_WEBPLOSSLESS='n'

    # comparison mode when enabled will when resizing and optimising images
    # write to a separate optimised image within the same directory as the
    # original images but with a suffix attached to the end of original image
    # file name i.e. image.png vs image_optimal.png
    COMPARE_MODE='y'
    COMPARE_SUFFIX='_optimal'

Then optimise for images at `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh optimise /home/nginx/domains/domain.com/public/images

Compare mode and webp enable, means, original image, optimised image and webp copies all reside in same directory for comparison. 

Optimised Image Profile for images at `/home/nginx/domains/domain.com/public/images` will list non-webp and webp images together but report average and total sizes separately.

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images                                                                                          
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    ------------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 6000 : 4000 : 98 : False : 8 : 7486415 : root : nginx
    image : dslr_canon_eos_77d_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 388237 : root : nginx
    image : dslr_canon_eos_77d_1.webp : 2048 : 1365 : 92 : False : 8 : 170488 : root : nginx
    image : dslr_canon_eos_77d_2.jpg : 6000 : 4000 : 98 : False : 8 : 8316182 : root : nginx
    image : dslr_canon_eos_77d_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 398208 : root : nginx
    image : dslr_canon_eos_77d_2.webp : 2048 : 1365 : 92 : False : 8 : 165680 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : dslr_canon_eos_m6_1.webp : 1200 : 800 : 92 : False : 8 : 61544 : root : nginx
    image : dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : nginx
    image : dslr_canon_eos_m6_large1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 304069 : root : nginx
    image : dslr_canon_eos_m6_large1.webp : 2048 : 1365 : 92 : False : 8 : 106656 : root : nginx
    image : dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : nginx
    image : dslr_canon_eos_m6_large2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 402584 : root : nginx
    image : dslr_canon_eos_m6_large2.webp : 2048 : 1365 : 92 : False : 8 : 162168 : root : nginx
    image : dslr_hasselblad_x1d_1.jpg : 8272 : 6200 : 92 : False : 8 : 8780571 : root : nginx
    image : dslr_hasselblad_x1d_1_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 441979 : root : nginx
    image : dslr_hasselblad_x1d_1.webp : 2048 : 1535 : 92 : False : 8 : 169388 : root : nginx
    image : dslr_hasselblad_x1d_2.jpg : 8272 : 6200 : 92 : False : 8 : 13022968 : root : nginx
    image : dslr_hasselblad_x1d_2_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 369580 : root : nginx
    image : dslr_hasselblad_x1d_2.webp : 2048 : 1535 : 92 : False : 8 : 115382 : root : nginx
    image : dslr_leica_m10_1.jpg : 5976 : 3984 : 94 : False : 8 : 9268289 : root : nginx
    image : dslr_leica_m10_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438656 : root : nginx
    image : dslr_leica_m10_1.webp : 2048 : 1365 : 92 : False : 8 : 201494 : root : nginx
    image : dslr_leica_m10_2.jpg : 5976 : 3984 : 94 : False : 8 : 7438563 : root : nginx
    image : dslr_leica_m10_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438587 : root : nginx
    image : dslr_leica_m10_2.webp : 2048 : 1365 : 92 : False : 8 : 212046 : root : nginx
    image : dslr_nikon_d5_1.jpg : 5568 : 3712 : 99 : False : 8 : 10454579 : root : nginx
    image : dslr_nikon_d5_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 287421 : root : nginx
    image : dslr_nikon_d5_1.webp : 2048 : 1365 : 92 : False : 8 : 110366 : root : nginx
    image : dslr_nikon_d5_2.jpg : 5568 : 3712 : 99 : False : 8 : 17263077 : root : nginx
    image : dslr_nikon_d5_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 310150 : root : nginx
    image : dslr_nikon_d5_2.webp : 2048 : 1365 : 92 : False : 8 : 99214 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : nginx
    image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : nginx
    image : dslr_nikon_d7200_1.webp : 2048 : 1365 : 92 : False : 8 : 173414 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : nginx
    image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : nginx
    image : dslr_nikon_d7200_2.webp : 1365 : 2048 : 92 : False : 8 : 212754 : root : nginx
    image : dslr_sony_alpha_a99_ii_1.jpg : 7952 : 5304 : 96 : False : 8 : 12444045 : root : nginx
    image : dslr_sony_alpha_a99_ii_1_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 349140 : root : nginx
    image : dslr_sony_alpha_a99_ii_1.webp : 2048 : 1366 : 92 : False : 8 : 162100 : root : nginx
    image : dslr_sony_alpha_a99_ii_2.jpg : 7952 : 5304 : 96 : False : 8 : 25899693 : root : nginx
    image : dslr_sony_alpha_a99_ii_2_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 431558 : root : nginx
    image : dslr_sony_alpha_a99_ii_2.webp : 2048 : 1366 : 92 : False : 8 : 178200 : root : nginx
    image : image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : nginx
    image : image1_optimal.jpg : 2048 : 1290 : 82 : False : 8 : 418884 : root : nginx
    image : image1.webp : 2048 : 1290 : 92 : False : 8 : 238790 : root : nginx
    image : image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : nginx
    image : image2_optimal.jpg : 2048 : 1248 : 82 : False : 8 : 282808 : root : nginx
    image : image2.webp : 2048 : 1248 : 92 : False : 8 : 115156 : root : nginx
    image : image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : nginx
    image : image3_optimal.jpg : 1600 : 1048 : 82 : False : 8 : 271018 : root : nginx
    image : image3.webp : 1600 : 1048 : 92 : False : 8 : 149990 : root : nginx
    image : image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : image4_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : image4.webp : 2048 : 1269 : 92 : False : 8 : 117758 : root : nginx
    image : im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : im age5_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : im age5.webp : 2048 : 1269 : 92 : False : 8 : 117758 : root : nginx
    image : image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : nginx
    image : image6_optimal.jpg : 640 : 427 : 82 : False : 8 : 71496 : root : nginx
    image : image6.webp : 640 : 427 : 92 : False : 8 : 48786 : root : nginx
    image : image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : nginx
    image : image7_optimal.jpg : 600 : 400 : 82 : False : 8 : 48906 : root : nginx
    image : image7.webp : 600 : 400 : 92 : False : 8 : 27068 : root : nginx
    image : lenna_optimal.png : 512 : 512 : 92 : False : 8 : 474955 : root : nginx
    image : lenna.png : 512 : 512 : 92 : False : 8 : 473831 : root : nginx
    image : lenna.webp : 512 : 512 : 92 : False : 8 : 20572 : root : nginx
    image : mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : nginx
    image : mobile1_optimal.jpg : 1200 : 900 : 82 : False : 8 : 280918 : root : nginx
    image : mobile1.webp : 1200 : 900 : 92 : False : 8 : 153574 : root : nginx
    image : mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : nginx
    image : mobile2_optimal.jpg : 1200 : 900 : 82 : False : 8 : 177339 : root : nginx
    image : mobile2.webp : 1200 : 900 : 92 : False : 8 : 73178 : root : nginx
    image : mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : nginx
    image : mobile3_optimal.jpg : 1200 : 900 : 82 : False : 8 : 217147 : root : nginx
    image : mobile3.webp : 1200 : 900 : 92 : False : 8 : 90900 : root : nginx
    image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : png24-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : nginx
    image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : png24-interlaced-image1.webp : 600 : 400 : 92 : False : 8 : 27104 : root : nginx
    image : pngimage1_optimal.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : nginx
    image : pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : nginx
    image : pngimage1.webp : 1623 : 2048 : 92 : True : 8 : 87360 : root : nginx
    image : pngimage2_optimal.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : nginx
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : nginx
    image : pngimage2.webp : 1700 : 1374 : 92 : True : 8 : 37534 : root : nginx
    image : pngimage3_optimal.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : nginx
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : nginx
    image : pngimage3.webp : 2000 : 1370 : 92 : True : 8 : 198494 : root : nginx
    image : pngimage4_optimal.png : 558 : 465 : 92 : True : 8 : 454890 : root : nginx
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : nginx
    image : pngimage4.webp : 558 : 465 : 92 : True : 8 : 46422 : root : nginx
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : nginx
    image : samsung_s7_mobile_1_optimal.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : nginx
    image : samsung_s7_mobile_1.webp : 2048 : 1536 : 92 : False : 8 : 69490 : root : nginx
    image : screenshot1_optimal.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : nginx
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : nginx
    image : screenshot1.webp : 1484 : 1095 : 92 : False : 8 : 79244 : root : nginx
    image : webp-study-source-firebreathing_optimal.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : nginx
    image : webp-study-source-firebreathing.webp : 1024 : 752 : 92 : False : 8 : 71860 : root : nginx
    image : webp-study-source-google-chart-tools_optimal.png : 1024 : 752 : 92 : True : 8 : 107292 : root : nginx
    image : webp-study-source-google-chart-tools.png : 1024 : 752 : 92 : True : 8 : 101911 : root : nginx
    image : webp-study-source-google-chart-tools.webp : 1024 : 752 : 92 : True : 8 : 53924 : root : nginx
    
    ------------------------------------------------------------------------------
    Original Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 3358      | 2431       | 93          | 4695297    | 169030698          | 165069          |
    
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
    Completion Time: 11.19 seconds
    ------------------------------------------------------------------------------

###### Summary

| Image State | Avg Width | Avg Height | Avg Quality | Avg Size (bytes) | Total Size (KB) | Reduction |
| --- | --- | --- | --- | --- | --- | --- | 
| Original Images | 3358 | 2431 | 93 | 4695297 | 165069.0 | |
| Optimised Default JpegOptim/OptiPNG | 1583 | 1147 | 85 | 328712 | 11556 | -93.00% |
| Optimised WebP | 1583 | 1147 | 92 | 115360 | 4056 | -97.54% |

 