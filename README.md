# tozd/base

<https://gitlab.com/tozd/docker/base>

Base Docker images used for other Docker images.

* Image with `ubuntu-trusty` tag is based on Ubuntu 14.04 LTS (Trusty)
* Image with `ubuntu-xenial` tag is based on Ubuntu 16.04 LTS (Xenial)
* Image with `ubuntu-bionic` tag is based on Ubuntu 18.04 LTS (Bionic)
* Image with `ubuntu-focal` tag is based on Ubuntu 20.04 LTS (Focal)
* Image with `alpine-38` tag is based on Alpine 3.8

It configures UTC as a container timezone.

Docker images are rebuild daily to get any latest (security) updates
from the underlying distribution.
If you do the same in your image (which extends this image), you will
get those updates as well.
