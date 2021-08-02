#!/bin/bash

CURRENT_SCRIPT_FULL_PATH=`realpath "$0"`

CURRENT_SCRIPT_NAME="$(basename -- $CURRENT_SCRIPT_FULL_PATH)"

if [ "$#" -ne 2 -a "$#" -ne 3 ]; then
    echo "Run example: ./$CURRENT_SCRIPT_NAME rtspServerAddressIn rtspServerAddressOut [fps-optional]"
fi

inRTSPAddress=$1
outRTSPAddress=$2

echo "Input rtsp address: $inRTSPAddress"
echo "Ouput rtsp address: $outRTSPAddress"

if [ "$#" -ne 2 ]; then
    fps=$3
    echo "Output fps: $fps"
fi

if [ "$#" -ne 2 ]; then
    command="ffmpeg -c:v hevc -rtsp_transport tcp -i $inRTSPAddress -vcodec libx264 -acodec copy -r "$fps" -pix_fmt yuv420p -f rtsp -rtsp_transport tcp $outRTSPAddress"
else
    command="ffmpeg -c:v hevc -rtsp_transport tcp -i $inRTSPAddress -vcodec libx264 -acodec copy -pix_fmt yuv420p -f rtsp -rtsp_transport tcp $outRTSPAddress"
fi

echo $command

$command

# Examples:
# ffmpeg -i rtsp://localhost:8554/live1 -vcodec libx264 -acodec copy -f rtsp -rtsp_transport tcp rtsp://localhost:8554/live2
# ffmpeg -rtsp_transport tcp -i rtsp://localhost:8554/live1 -vcodec libx264 -acodec copy -r 15 -f rtsp -rtsp_transport tcp rtsp://localhost:8554/live2
