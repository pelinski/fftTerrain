# bloodyTerrains
3d mesh of the signal coming out of the bloodbathslaughterdiscomachine
programmed on processing to be run in raspberry pi.

## Status
Working on Laptop (MacOS) but not on pi, looks like pi doesn't like processing3D (P3D)

## The mesh
2d grid with triangles

each vertex is indexed with [x][y]

[x] is the frequency bins

[y] is the timeline

the vertex/nodes are moved in the [z] direction using the amplitude of the fft

## Usage on raspberryPi
```
cd yourdir
DISPLAY=:0 processing-java --sketch=yourdir\terrainMirror --run
```
## Contents
* terrainMirror: uses fullScreen(P3D) as renderer, audioInput (mic/input signal)
* terrainMirrorScr: uses size(1200,600,P3D) instead, sampleInput (wav file)
