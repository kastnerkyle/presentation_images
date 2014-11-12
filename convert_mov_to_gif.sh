#!/bin/bash

fname=$1
gifname=`basename $fname .mov`.gif

# Lower quality but works
# http://superuser.com/questions/436056/how-can-i-get-ffmpeg-to-convert-a-mov-to-a-gif
#ffmpeg -ss 00:00:00.000 -i $fname -r 10 -s 240x240 -t 00:00:30.000 $gifname
#convert $gifname -layers Optimize $gifname

# Higher quality
# http://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
mkdir frames
ffmpeg -ss 00:00:00.000 -i $fname -vf scale=200:-1 -r 10 -t 00:00:5:000 frames/ffout%03d.png
ordered=`( ls -v frames/ffout*.png ; ls -vr frames/ffout*.png )`
convert -delay 5 -loop 0 $ordered $gifname 
rm -r frames
convert $gifname -layers Optimize $gifname
