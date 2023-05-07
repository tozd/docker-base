# tozd/base

<https://gitlab.com/tozd/docker/base>

Available as:

- [`tozd/base`](https://hub.docker.com/r/tozd/base)
- [`registry.gitlab.com/tozd/docker/base`](https://gitlab.com/tozd/docker/base/container_registry)

## Tags

- `ubuntu-trusty`: Ubuntu 14.04 LTS (Trusty)
- `ubuntu-xenial`: Ubuntu 16.04 LTS (Xenial)
- `ubuntu-bionic`: Ubuntu 18.04 LTS (Bionic)
- `ubuntu-focal`: Ubuntu 20.04 LTS (Focal)
- `ubuntu-jammy`: Ubuntu 22.04 LTS (Jammy)
- `alpine-38`: Alpine 3.8
- `alpine-310`: Alpine 3.10
- `alpine-312`: Alpine 3.12
- `alpine-314`: Alpine 3.14
- `alpine-316`: Alpine 3.16

## Description

Base Docker images used for other Docker images.

It configures UTC as a container timezone and `en_US.UTF-8` for container's locale.

All images are rebuild daily to get any latest (security) updates from
the underlying distribution.
If you do the same in your image (which extends any of these images), you will
get those updates as well.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-base),
if you need to fork the project there.
