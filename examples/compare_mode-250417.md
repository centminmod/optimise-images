Using [optimise-images.sh](https://github.com/centminmod/optimise-images) to batch optimise and profile a directory of images.

Added a optional compare mode via `COMPARE_MODE='y'` which allows you to resize and optimise the original image but write to a separate file with a preset suffix within the same directory.

Default `optimise-images.sh` settings has disabled `COMPARE_MODE='n'`

    IMAGICK_RESIZE='y'
    IMAGICK_QUALITY='82'
    OPTIPNG='y'
    JPEGOPTIM='y'
    ZOPFLIPNG='n'
    
    # Speed control
    # default is -o2 set 2
    OPTIPNG_COMPRESSION='2'
    
    # max width and height
    MAXRES='2048'
    
    # strip meta-data
    STRIP='y'
    
    # profile option display fields for transparency color and background color
    # disabled by default to speed up profile processing
    PROFILE_EXTEND='n'
    
    # comparison mode when enabled will when resizing and optimising images
    # write to a separate optimised image within the same directory as the
    # original images but with a suffix attached to the end of original image
    # file name i.e. image.png vs image_optimal.png
    COMPARE_MODE='n'
    COMPARE_SUFFIX='_optimal'

when you enable compare mode via:

    COMPARE_MODE='n'

images are optimised and resized into separate file with suffix defined by `COMPARE_SUFFIX='_optimal'`

`optimise` command run against images in `/home/nginx/domains/domain.com/public/images` directory

    /root/tools/optimise-images/optimise-images.sh optimise /home/nginx/domains/domain.com/public/images

and running `profile` command will report the average file sizes and total file sizes separately

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images                                                                                          

    -------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    -------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    -------------------------------------------------------------------------
    image : dslr_canon_eos_77d_1.jpg : 6000 : 4000 : 98 : False : 8 : 7486415 : root : nginx
    image : dslr_canon_eos_77d_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 388237 : root : nginx
    image : dslr_canon_eos_77d_2.jpg : 6000 : 4000 : 98 : False : 8 : 8316182 : root : nginx
    image : dslr_canon_eos_77d_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 398208 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : dslr_canon_eos_m6_1_optimal.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : dslr_canon_eos_m6_large1.jpg : 6000 : 4000 : 96 : False : 8 : 11963731 : root : nginx
    image : dslr_canon_eos_m6_large1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 304069 : root : nginx
    image : dslr_canon_eos_m6_large2.jpg : 6000 : 4000 : 96 : False : 8 : 10116772 : root : nginx
    image : dslr_canon_eos_m6_large2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 402584 : root : nginx
    image : dslr_hasselblad_x1d_1.jpg : 8272 : 6200 : 92 : False : 8 : 8780571 : root : nginx
    image : dslr_hasselblad_x1d_1_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 441979 : root : nginx
    image : dslr_hasselblad_x1d_2.jpg : 8272 : 6200 : 92 : False : 8 : 13022968 : root : nginx
    image : dslr_hasselblad_x1d_2_optimal.jpg : 2048 : 1535 : 82 : False : 8 : 369580 : root : nginx
    image : dslr_leica_m10_1.jpg : 5976 : 3984 : 94 : False : 8 : 9268289 : root : nginx
    image : dslr_leica_m10_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438656 : root : nginx
    image : dslr_leica_m10_2.jpg : 5976 : 3984 : 94 : False : 8 : 7438563 : root : nginx
    image : dslr_leica_m10_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 438587 : root : nginx
    image : dslr_nikon_d5_1.jpg : 5568 : 3712 : 99 : False : 8 : 10454579 : root : nginx
    image : dslr_nikon_d5_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 287421 : root : nginx
    image : dslr_nikon_d5_2.jpg : 5568 : 3712 : 99 : False : 8 : 17263077 : root : nginx
    image : dslr_nikon_d5_2_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 310150 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : nginx
    image : dslr_nikon_d7200_1_optimal.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : nginx
    image : dslr_nikon_d7200_2_optimal.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : nginx
    image : dslr_sony_alpha_a99_ii_1.jpg : 7952 : 5304 : 96 : False : 8 : 12444045 : root : nginx
    image : dslr_sony_alpha_a99_ii_1_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 349140 : root : nginx
    image : dslr_sony_alpha_a99_ii_2.jpg : 7952 : 5304 : 96 : False : 8 : 25899693 : root : nginx
    image : dslr_sony_alpha_a99_ii_2_optimal.jpg : 2048 : 1366 : 82 : False : 8 : 431558 : root : nginx
    image : image1.jpg : 2048 : 1290 : 96 : False : 8 : 1440775 : root : nginx
    image : image1_optimal.jpg : 2048 : 1290 : 82 : False : 8 : 418884 : root : nginx
    image : image2.jpg : 2048 : 1248 : 96 : False : 8 : 964753 : root : nginx
    image : image2_optimal.jpg : 2048 : 1248 : 82 : False : 8 : 282808 : root : nginx
    image : image3.jpg : 1600 : 1048 : 93 : False : 8 : 637134 : root : nginx
    image : image3_optimal.jpg : 1600 : 1048 : 82 : False : 8 : 271018 : root : nginx
    image : image4.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : image4_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : im age5.jpg : 2048 : 1269 : 96 : False : 8 : 706095 : root : nginx
    image : im age5_optimal.jpg : 2048 : 1269 : 82 : False : 8 : 269134 : root : nginx
    image : image6.jpg : 640 : 427 : 80 : False : 8 : 96320 : root : nginx
    image : image6_optimal.jpg : 640 : 427 : 82 : False : 8 : 71496 : root : nginx
    image : image7.jpg : 600 : 400 : 99 : False : 8 : 227997 : root : nginx
    image : image7_optimal.jpg : 600 : 400 : 82 : False : 8 : 48906 : root : nginx
    image : mobile1.jpg : 1200 : 900 : 90 : False : 8 : 345814 : root : nginx
    image : mobile1_optimal.jpg : 1200 : 900 : 82 : False : 8 : 280918 : root : nginx
    image : mobile2.jpg : 1200 : 900 : 90 : False : 8 : 220781 : root : nginx
    image : mobile2_optimal.jpg : 1200 : 900 : 82 : False : 8 : 177339 : root : nginx
    image : mobile3.jpg : 1200 : 900 : 90 : False : 8 : 267847 : root : nginx
    image : mobile3_optimal.jpg : 1200 : 900 : 82 : False : 8 : 217147 : root : nginx
    image : png24-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : png24-interlaced-image1_optimal.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : pngimage1_optimal.png : 1623 : 2048 : 92 : True : 8 : 246604 : root : nginx
    image : pngimage1.png : 2000 : 2523 : 92 : True : 8 : 210778 : root : nginx
    image : pngimage2_optimal.png : 1700 : 1374 : 92 : True : 8 : 19228 : root : nginx
    image : pngimage2.png : 1700 : 1374 : 92 : True : 8 : 40680 : root : nginx
    image : pngimage3_optimal.png : 2000 : 1370 : 92 : True : 8 : 284292 : root : nginx
    image : pngimage3.png : 2000 : 1370 : 92 : True : 8 : 448000 : root : nginx
    image : pngimage4_optimal.png : 558 : 465 : 92 : True : 8 : 454890 : root : nginx
    image : pngimage4.png : 558 : 465 : 92 : True : 8 : 456035 : root : nginx
    image : screenshot1_optimal.png : 1484 : 1095 : 92 : False : 8 : 104676 : root : nginx
    image : screenshot1.png : 1484 : 1095 : 92 : False : 8 : 152566 : root : nginx
    
    -------------------------------------------------------------------------
    average image width, height, image quality and size
    -------------------------------------------------------------------------
    3572 2577 94 5160864
    
    -------------------------------------------------------------------------
    Optimised Images: average image width, height, image quality and size
    -------------------------------------------------------------------------
    1637 1179 84 306282
    
    -------------------------------------------------------------------------
    Total Images Size: 165147643 Bytes 161277 KB
    -------------------------------------------------------------------------
    
    -------------------------------------------------------------------------
    Total Optimised Images Size: 9801033 Bytes 9571.32 KB
    -------------------------------------------------------------------------

directory listing

    ls -lah /home/nginx/domains/domain.com/public/images
    total 168M
    drwxr-sr-x  2 root  nginx 4.0K Apr 24 19:49 .
    drwxr-s---. 4 nginx nginx 4.0K Apr 23 06:35 ..
    -rw-r--r--  1 root  nginx 7.2M Mar 23 10:17 dslr_canon_eos_77d_1.jpg
    -rw-r--r--  1 root  nginx 380K Apr 24 19:47 dslr_canon_eos_77d_1_optimal.jpg
    -rw-r--r--  1 root  nginx 8.0M Mar 23 10:05 dslr_canon_eos_77d_2.jpg
    -rw-r--r--  1 root  nginx 389K Apr 24 19:47 dslr_canon_eos_77d_2_optimal.jpg
    -rw-r--r--  1 root  nginx 203K Apr 24 19:19 dslr_canon_eos_m6_1.jpg
    -rw-r--r--  1 root  nginx 158K Apr 24 19:47 dslr_canon_eos_m6_1_optimal.jpg
    -rw-r--r--  1 root  nginx  12M Mar 28 10:11 dslr_canon_eos_m6_large1.jpg
    -rw-r--r--  1 root  nginx 297K Apr 24 19:47 dslr_canon_eos_m6_large1_optimal.jpg
    -rw-r--r--  1 root  nginx 9.7M Mar 28 10:03 dslr_canon_eos_m6_large2.jpg
    -rw-r--r--  1 root  nginx 394K Apr 24 19:47 dslr_canon_eos_m6_large2_optimal.jpg
    -rw-r--r--  1 root  nginx 8.4M Apr 15 10:07 dslr_hasselblad_x1d_1.jpg
    -rw-r--r--  1 root  nginx 432K Apr 24 19:48 dslr_hasselblad_x1d_1_optimal.jpg
    -rw-r--r--  1 root  nginx  13M Apr 15 10:10 dslr_hasselblad_x1d_2.jpg
    -rw-r--r--  1 root  nginx 361K Apr 24 19:48 dslr_hasselblad_x1d_2_optimal.jpg
    -rw-r--r--  1 root  nginx 8.9M Jan 18 20:08 dslr_leica_m10_1.jpg
    -rw-r--r--  1 root  nginx 429K Apr 24 19:48 dslr_leica_m10_1_optimal.jpg
    -rw-r--r--  1 root  nginx 7.1M Jan 18 20:13 dslr_leica_m10_2.jpg
    -rw-r--r--  1 root  nginx 429K Apr 24 19:48 dslr_leica_m10_2_optimal.jpg
    -rw-r--r--  1 root  nginx  10M Apr 18  2016 dslr_nikon_d5_1.jpg
    -rw-r--r--  1 root  nginx 281K Apr 24 19:48 dslr_nikon_d5_1_optimal.jpg
    -rw-r--r--  1 root  nginx  17M Apr 18  2016 dslr_nikon_d5_2.jpg
    -rw-r--r--  1 root  nginx 303K Apr 24 19:48 dslr_nikon_d5_2_optimal.jpg
    -rw-r--r--  1 root  nginx  11M Aug 10  2015 dslr_nikon_d7200_1.jpg
    -rw-r--r--  1 root  nginx 367K Apr 24 19:48 dslr_nikon_d7200_1_optimal.jpg
    -rw-r--r--  1 root  nginx 3.8M Aug 11  2015 dslr_nikon_d7200_2.jpg
    -rw-r--r--  1 root  nginx 505K Apr 24 19:48 dslr_nikon_d7200_2_optimal.jpg
    -rw-r--r--  1 root  nginx  12M Jan  4 21:26 dslr_sony_alpha_a99_ii_1.jpg
    -rw-r--r--  1 root  nginx 341K Apr 24 19:48 dslr_sony_alpha_a99_ii_1_optimal.jpg
    -rw-r--r--  1 root  nginx  25M Feb  4 10:37 dslr_sony_alpha_a99_ii_2.jpg
    -rw-r--r--  1 root  nginx 422K Apr 24 19:49 dslr_sony_alpha_a99_ii_2_optimal.jpg
    -rw-r--r--  1 root  nginx 1.4M Apr 24 19:19 image1.jpg
    -rw-r--r--  1 root  nginx 410K Apr 24 19:49 image1_optimal.jpg
    -rw-r--r--  1 root  nginx 943K Apr 24 19:19 image2.jpg
    -rw-r--r--  1 root  nginx 277K Apr 24 19:49 image2_optimal.jpg
    -rw-r--r--  1 root  nginx 623K Apr 24 19:19 image3.jpg
    -rw-r--r--  1 root  nginx 265K Apr 24 19:49 image3_optimal.jpg
    -rw-r--r--  1 root  nginx 690K Apr 24 19:19 image4.jpg
    -rw-r--r--  1 root  nginx 263K Apr 24 19:49 image4_optimal.jpg
    -rw-r--r--  1 root  nginx 690K Apr 24 19:19 im age5.jpg
    -rw-r--r--  1 root  nginx 263K Apr 24 19:49 im age5_optimal.jpg
    -rw-r--r--  1 root  nginx  95K Apr 24 19:19 image6.jpg
    -rw-r--r--  1 root  nginx  70K Apr 24 19:49 image6_optimal.jpg
    -rw-r--r--  1 root  nginx 223K Apr 24 19:19 image7.jpg
    -rw-r--r--  1 root  nginx  48K Apr 24 19:49 image7_optimal.jpg
    -rw-r--r--  1 root  nginx 338K Apr 24 19:19 mobile1.jpg
    -rw-r--r--  1 root  nginx 275K Apr 24 19:49 mobile1_optimal.jpg
    -rw-r--r--  1 root  nginx 216K Apr 24 19:19 mobile2.jpg
    -rw-r--r--  1 root  nginx 174K Apr 24 19:49 mobile2_optimal.jpg
    -rw-r--r--  1 root  nginx 262K Apr 24 19:19 mobile3.jpg
    -rw-r--r--  1 root  nginx 213K Apr 24 19:49 mobile3_optimal.jpg
    -rw-r--r--  1 root  nginx 378K Apr 24 19:49 png24-image1_optimal.png
    -rw-r--r--  1 root  nginx 392K Apr 24 19:19 png24-image1.png
    -rw-r--r--  1 root  nginx 378K Apr 24 19:49 png24-interlaced-image1_optimal.png
    -rw-r--r--  1 root  nginx 447K Apr 24 19:19 png24-interlaced-image1.png
    -rw-r--r--  1 root  nginx 241K Apr 24 19:49 pngimage1_optimal.png
    -rw-r--r--  1 root  nginx 206K Apr 24 19:19 pngimage1.png
    -rw-r--r--  1 root  nginx  19K Apr 24 19:49 pngimage2_optimal.png
    -rw-r--r--  1 root  nginx  40K Apr 24 19:19 pngimage2.png
    -rw-r--r--  1 root  nginx 278K Apr 24 19:49 pngimage3_optimal.png
    -rw-r--r--  1 root  nginx 438K Apr 24 19:19 pngimage3.png
    -rw-r--r--  1 root  nginx 445K Apr 24 19:49 pngimage4_optimal.png
    -rw-r--r--  1 root  nginx 446K Apr 24 19:19 pngimage4.png
    -rw-r--r--  1 root  nginx 103K Apr 24 19:49 screenshot1_optimal.png
    -rw-r--r--  1 root  nginx 149K Apr 24 19:19 screenshot1.png