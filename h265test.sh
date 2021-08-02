#!/bin/bash

CURRENT_SCRIPT_FULL_PATH=`realpath "$0"`

CURRENT_SCRIPT_NAME="$(basename -- $CURRENT_SCRIPT_FULL_PATH)"

if [ "$#" -ne 2 -a "$#" -ne 3 ]; then
    echo "Run example: ./$CURRENT_SCRIPT_NAME videoFileIn rtspServerAddressOut [fps-optional]"
fi

inFile=$1
outRTSPAddress=$2

echo "Input video file: $inFile"
echo "Ouput rtsp address: $outRTSPAddress"

if [ "$#" -ne 2 ]; then
    fps=$3
    echo "Output fps: $fps"

fi

if [ "$#" -ne 2 ]; then
    command="ffmpeg -re -i $inFile -vcodec libx265 -acodec copy -r $fps -f rtsp -rtsp_transport tcp $outRTSPAddress"
else
    command="ffmpeg -re -i $inFile -vcodec libx265 -acodec copy -f rtsp -rtsp_transport tcp $outRTSPAddress"
fi

echo $command

$command

# Examples:
# ffmpeg -re -i input.mp4 -vcodec libx265 -acodec copy -r 15 -f rtsp -rtsp_transport tcp rtsp://localhost:8554/live1
# ffmpeg -re -i input.mp4 -vcodec libx265 -acodec copy -f rtsp -rtsp_transport tcp rtsp://localhost:8554/live1
