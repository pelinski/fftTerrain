# bloodyTerrains
3d mesh of the signal coming out of the bloodbathslaughterdiscomachine
programmed on processing to be run in raspberry pi.

## Requisites
### Sound Library
Download from the Import Library assistant in processing

### Mesa
Download the Mesa3D repo on the pi
```
git clone https://github.com/mesa3d/mesa.git
```
once its done,

```
cd
mkdir build
cd build
meson ..
sudo ninja install
```
This repo renders the P3D. You cannot use fullScreen(P3D) anymore and need to use
```
size (displayWidth, displayHeight, P3D)
```
instead.

## Status
Working on Laptop (MacOS) but not on pi, looks like pi doesn't like processing3D (P3D)

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
