# bloodyTerrains
3d mesh of the signal coming out of the bloodbathslaughterdiscomachine
programmed on processing to be run in raspberry pi.

## Requisites
### Sound Library
Download from the Import Library assistant in processing

### Mesa
```
sudo raspi-config
```
Under Advanced Options > GL Driver choose **GL (Full KMS)**.

### GPU
Under Raspberry Pi Configuration > Performance > set "GPU memory" higher. Reboot. If the raspberryPi doesn't boot, reboot manually and access Recovery Mode, change the config.txt file and reduce the GPU number there.

## Status
Working on Laptop (MacOS) with high resolution. Working on on pi but much slower and only after using the experimental GL driver and after having improved the GPU. Looks like pi doesn't like processing3D (P3D). Further work: make the fft go slower (instead of performing it after n samples, perform it after 2*n samples). At the moment it goes faster as the driver graphics can render.

## The mesh
2d grid with squares divided by its diagonal in triangles. Each vertex is indexed with [x][y], where:
* \[x] is the frequency bins
* [y] is the timeline

The vertex/nodes are then moved in the [z] direction using the amplitude of the fft

## Usage on raspberryPi
```
cd yourdir
DISPLAY=:0 processing-java --sketch=yourdir\terrainMirror --run
```
## Contents
* terrainMirror: uses fullScreen(P3D) as renderer, audioInput (mic/input signal)
* terrainMirrorScr: uses size(1200,600,P3D) instead, sampleInput (wav file)

## References
*
