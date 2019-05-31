# blood
3d mesh of the signal coming out of the bloodbathslaughterdiscomachine
programmed on processing to be run in raspberry pi


2d grid with triangles
each vertex is indexed with [x][y]
[x] is the frequency bins
[y] is the timeline
the vertex/nodes are moved in the [z] direction using the amplitude of the fft

#Usage on raspberrypi
cd dir where the sketch folder lies
$ DISPLAY=:0 processing-java --sketch=terrainMirror --run

Currently not working, looks like pi doesn't support processing 3d ;(
