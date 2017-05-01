Using [optimise-images.sh](https://github.com/centminmod/optimise-images) with new `optimise-webp-nginx` mode so instead of manually setting `IMAGICK_WEBP='y'` as in example at [WebP conversion](/examples/examples-webp-260417.md), you can automatically set it from command line and it automatically outputs a sample Nginx vhost configuration so you can conditionally server WebP images to web browsers that support it - [example for Nginx](https://centminmod.com/webp/). For more info on [WebP](https://developers.google.com/speed/webp/).

Usage options:

    ./optimise-images.sh 
    ./optimise-images.sh {optimise} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-webp} /PATH/TO/DIRECTORY/WITH/IMAGES
    ./optimise-images.sh {optimise-webp-nginx} /PATH/TO/DIRECTORY/WITH/IMAGES
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

Original Image Profile for images at `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh profile /home/nginx/domains/domain.com/public/images                                       
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-300417-190052.log
    ------------------------------------------------------------------------------
    image : bees.png : 444 : 258 : 92 : False : 8 : 177424 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 90 : False : 8 : 207430 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 6000 : 4000 : 96 : False : 8 : 10806424 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 4000 : 6000 : 90 : False : 8 : 3899287 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 400998 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 456949 : root : nginx
    image : samsung_s7_mobile_1.jpg : 4032 : 3024 : 92 : False : 8 : 2100858 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1206455 : root : nginx
    
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

`IMAGICK_WEBP` variable controls whether to create the webp copy and `IMAGICK_WEBPLOSSLES` controls whether webp copy is lossless or glossy. It defaults to `IMAGICK_WEBP='n'` and `IMAGICK_WEBPLOSSLESS='n'` so you need to change the default settings usually.

from

    IMAGICK_WEBP='n'
    IMAGICK_WEBPQUALITY='75'
    IMAGICK_WEBPMETHOD='4'
    IMAGICK_WEBPLOSSLESS='n'

to

    IMAGICK_WEBP='y'
    IMAGICK_WEBPQUALITY='75'
    IMAGICK_WEBPMETHOD='4'
    IMAGICK_WEBPLOSSLESS='n'

But with the new `optimise-webp-nginx` command, this can be done automatically and a bonus is it outputs a sample Nginx vhost configuration so you can conditionally server WebP images to web browsers that support it - [example for Nginx](https://centminmod.com/webp/).

Then optimise for images at `/home/nginx/domains/domain.com/public/images`

    /root/tools/optimise-images/optimise-images.sh optimise-webp-nginx /home/nginx/domains/domain.com/public/images

`optimise-webp-nginx` mode automatically runs the profiler routine listing immediately after the optimisation and will list non-webp and webp images together but report average and total sizes separately. Additionally, a static image gallery named `gallery-webp.html` is created in image directory which lists the original optimised file side by side with the webp converted file so you can visually compare the two. You can disable static gallery generation by setting `GALLERY_WEBP='n'` within `optimise-images.sh` script.

    <!DOCTYPE html>
    <html lang='en-us'>
    <head>
    <meta charset='utf-8'>
    <title>Original vs WebP</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <style>
    #group-wrap { width:100%; max-width:640px; margin:auto 0; text-align:center }
    .section { clear:both; padding:0; margin:0 }
    .col { display:block; float:left; margin:1% 0 1% 1.6% }
    .col:first-child { margin-left:1.6% }
    .group:before,.group:after { content:""; display:table }
    .group:after { clear:both }
    .group { zoom:1 }
    .span_2_of_2 { width:100% }
    .span_1_of_2 { width:48.2% }
    @media only screen and (max-width: 480px) { .col { margin:1% 0 } .span_2_of_2,.span_1_of_2 { width:50% } }
    </style>
    </head>
    
    <body>
    <div id="group-wrap">
    <div class="section group">
    
            <div class="col span_1_of_2">
            <a href="bees.png"> <img src="bees.png" alt="original 444x258 (png 171.18 KB)" width="240px" /></a>
            <p>original 444x258 (png 171.18 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="bees.png.webp"> <img src="bees.png.webp" alt="webp 444x258 (webp 10.27 KB)" width="240px" /></a>
            <p>webp 444x258 (webp 10.27 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="dslr_canon_eos_m6_1.jpg"> <img src="dslr_canon_eos_m6_1.jpg" alt="original 1200x800 (jpg 157.31 KB)" width="240px" /></a>
            <p>original 1200x800 (jpg 157.31 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="dslr_canon_eos_m6_1.jpg.webp"> <img src="dslr_canon_eos_m6_1.jpg.webp" alt="webp 1200x800 (webp 60.10 KB)" width="240px" /></a>
            <p>webp 1200x800 (webp 60.10 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="dslr_nikon_d7200_1.jpg"> <img src="dslr_nikon_d7200_1.jpg" alt="original 2048x1365 (jpg 366.16 KB)" width="240px" /></a>
            <p>original 2048x1365 (jpg 366.16 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="dslr_nikon_d7200_1.jpg.webp"> <img src="dslr_nikon_d7200_1.jpg.webp" alt="webp 2048x1365 (webp 169.34 KB)" width="240px" /></a>
            <p>webp 2048x1365 (webp 169.34 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="dslr_nikon_d7200_2.jpg"> <img src="dslr_nikon_d7200_2.jpg" alt="original 1365x2048 (jpg 504.12 KB)" width="240px" /></a>
            <p>original 1365x2048 (jpg 504.12 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="dslr_nikon_d7200_2.jpg.webp"> <img src="dslr_nikon_d7200_2.jpg.webp" alt="webp 1365x2048 (webp 207.76 KB)" width="240px" /></a>
            <p>webp 1365x2048 (webp 207.76 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="png24-image1.png"> <img src="png24-image1.png" alt="original 600x400 (png 377.01 KB)" width="240px" /></a>
            <p>original 600x400 (png 377.01 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="png24-image1.png.webp"> <img src="png24-image1.png.webp" alt="webp 600x400 (webp 26.46 KB)" width="240px" /></a>
            <p>webp 600x400 (webp 26.46 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="png24-interlaced-image1.png"> <img src="png24-interlaced-image1.png" alt="original 600x400 (png 433.52 KB)" width="240px" /></a>
            <p>original 600x400 (png 433.52 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="png24-interlaced-image1.png.webp"> <img src="png24-interlaced-image1.png.webp" alt="webp 600x400 (webp 26.46 KB)" width="240px" /></a>
            <p>webp 600x400 (webp 26.46 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="samsung_s7_mobile_1.jpg"> <img src="samsung_s7_mobile_1.jpg" alt="original 2048x1536 (jpg 250.24 KB)" width="240px" /></a>
            <p>original 2048x1536 (jpg 250.24 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="samsung_s7_mobile_1.jpg.webp"> <img src="samsung_s7_mobile_1.jpg.webp" alt="webp 2048x1536 (webp 67.86 KB)" width="240px" /></a>
            <p>webp 2048x1536 (webp 67.86 KB)</p>
            </div>
        
    
            <div class="col span_1_of_2">
            <a href="webp-study-source-firebreathing.png"> <img src="webp-study-source-firebreathing.png" alt="original 1024x752 (png 1166.10 KB)" width="240px" /></a>
            <p>original 1024x752 (png 1166.10 KB)</p>
            </div>
            <div class="col span_1_of_2">
            <a href="webp-study-source-firebreathing.png.webp"> <img src="webp-study-source-firebreathing.png.webp" alt="webp 1024x752 (webp 70.17 KB)" width="240px" /></a>
            <p>webp 1024x752 (webp 70.17 KB)</p>
            </div>
        
    </div>
    </div>
    </body>
    </html>
    
    ------------------------------------------------------------------------------
    image profile
    image name : width : height : quality : transparency : image depth (bits) : size : user: group
    ------------------------------------------------------------------------------
    images in /home/nginx/domains/domain.com/public/images
    logged at /home/optimise-logs/profile-log-300417-190254.log
    ------------------------------------------------------------------------------
    image : bees.png : 444 : 258 : 92 : False : 8 : 175296 : root : nginx
    image : bees.png.webp : 444 : 258 : 92 : False : 8 : 10520 : root : nginx
    image : dslr_canon_eos_m6_1.jpg : 1200 : 800 : 82 : False : 8 : 161086 : root : nginx
    image : dslr_canon_eos_m6_1.jpg.webp : 1200 : 800 : 92 : False : 8 : 61544 : root : nginx
    image : dslr_nikon_d7200_1.jpg : 2048 : 1365 : 82 : False : 8 : 374954 : root : nginx
    image : dslr_nikon_d7200_1.jpg.webp : 2048 : 1365 : 92 : False : 8 : 173414 : root : nginx
    image : dslr_nikon_d7200_2.jpg : 1365 : 2048 : 82 : False : 8 : 516224 : root : nginx
    image : dslr_nikon_d7200_2.jpg.webp : 1365 : 2048 : 92 : False : 8 : 212754 : root : nginx
    image : png24-image1.png : 600 : 400 : 92 : False : 8 : 386063 : root : nginx
    image : png24-image1.png.webp : 600 : 400 : 92 : False : 8 : 27104 : root : nginx
    image : png24-interlaced-image1.png : 600 : 400 : 92 : False : 8 : 443931 : root : nginx
    image : png24-interlaced-image1.png.webp : 600 : 400 : 92 : False : 8 : 27104 : root : nginx
    image : samsung_s7_mobile_1.jpg : 2048 : 1536 : 82 : False : 8 : 256253 : root : nginx
    image : samsung_s7_mobile_1.jpg.webp : 2048 : 1536 : 92 : False : 8 : 69490 : root : nginx
    image : webp-study-source-firebreathing.png : 1024 : 752 : 92 : False : 8 : 1194091 : root : nginx
    image : webp-study-source-firebreathing.png.webp : 1024 : 752 : 92 : False : 8 : 71860 : root : nginx
    
    ------------------------------------------------------------------------------
    Original or Existing Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 87          | 438487     | 3507898            | 3426            |
    
    ------------------------------------------------------------------------------
    Optimised WebP Images:
    ------------------------------------------------------------------------------
    | Avg width | Avg height | Avg quality | Avg size   | Total size (Bytes) | Total size (KB) |
    | --------- | ---------- | ----------- | --------   | ------------------ | --------------- |
    | 1166      | 945        | 92          | 81724      | 653790             | 638             |
    
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
    Completion Time: 0.30 seconds
    ------------------------------------------------------------------------------
    
    See https://centminmod.com/webp/ for more details
    sample nginx vhost locaton context for conditional webp serving
    
    create /usr/local/nginx/conf/webp.conf and add to it:
    
    
    map $http_accept $webp_extension {
        default "";
        "~*webp" ".webp";
    }
    
    add to your nginx.conf i.e. /usr/local/nginx/conf/nginx.conf and
    include file for /usr/local/nginx/conf/webp.conf within the
    http{} context location
    
    include /usr/local/nginx/conf/webp.conf;
    
    Then within your nginx vhost add or append/edit your location for
    

    location /images {
    #pagespeed off;
    autoindex on;
    add_header X-Robots-Tag "noindex, nofollow";
    location ~* ^/images/.+\.(png|jpe?g)$ {
        expires 30d;
        add_header Vary "Accept-Encoding";
        add_header Cache-Control "public, no-transform";
        try_files $uri$webp_extension $uri =404;
    }
    }

###### Gallery

Generated gallery output with original resized/optimised on left and webp converted on right.

![](/examples/examples-optimise-webp-nginx-300417/gallery-webp1.png) ![](/examples/examples-optimise-webp-nginx-300417/gallery-webp2.png)

###### Summary

| Image State | Avg Width | Avg Height | Avg Quality | Avg Size (bytes) | Total Size (KB) | Reduction |
| --- | --- | --- | --- | --- | --- | --- | 
| Original Images | 2238      | 1954       | 92          | 2406978    |  18805           | |
| Optimised Default JpegOptim/OptiPNG | 1166      | 945        | 87          | 438487     | 3426            | -81.78% |
| Optimised WebP | 1166      | 945        | 92          | 81724      | 638             | -96.61% |