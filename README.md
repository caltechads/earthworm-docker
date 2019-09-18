# earthworm-docker

[Earthworm](http://www.earthwormcentral.org/) is an open
architecture, open source public software for data acquisition, processing,
archival and distribution of seismic data.  It is widely used by seismic
research facilities around the world..

`earthworm-docker` is an earthworm install in a Docker container, based
on Centos:7.

## Available image tags in Docker Hub

 * `cmalek/earthworm:7.9`: the latest version of the Earthworm 7.9 container
 * `cmalek/earthworm:7.9-build1`: the specific tag of latest version of the
   Earthworm 7.9 container.  Use this is you want to pin to a specific image of
   `cmalek/earthworm:7.9`

## Caveats

All parts of earthworm seem to work in the container, except for
[nmxptool](http://mednet.rm.ingv.it/nmxptool.php), which I couldn't get to
build.

## Testing

You can run the container via

```
docker-compose up
```

And then exec into the container like so:

```
docker exec -ti earthworm bash
```

This container mounts the configs in `etc/ew/params`, which set up a few
ring buffers and run `tankplayer`.  You can inspect the data that `tankplayer`
inserts into `WAVE_RING` like so:

```
sniffwave WAVE_RING
```
