# FFmpeg Transcoder

Run docker container with rstp server:

```sh
docker run --rm -it -e RTSP_PROTOCOLS=tcp -p 8554:8554 -p 1935:1935 aler9/rtsp-simple-server
```

Encode a local video file in h265 and stream to rtsp server:
```sh
./h265test.sh input.mp4 rtsp://localhost:8554/live1 15
```
Play h265 rtsp stream:
```sh
ffplay -rtsp_transport tcp rtsp://localhost:8554/live1
```
Transcode an input rtsp h265 to an output rtsp as h264
```sh
./transcode.sh rtsp://localhost:8554/live1 rtsp://localhost:8554/live2
```
Play rtsp transcoded
```sh
ffplay -rtsp_transport tcp rtsp://localhost:8554/live2
```
