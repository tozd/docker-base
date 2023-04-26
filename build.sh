#!/bin/sh -s -eo pipefail

if [ -n "${DOCKER_HUB_PASSWORD}" -a -n "${DOCKER_HUB_USERNAME}" -a "${CI_COMMIT_REF_NAME}" = master ]; then
  echo "${DOCKER_HUB_PASSWORD}" | docker login --username "${DOCKER_HUB_USERNAME}" --password-stdin
  mkdir -p "$HOME/.docker/cli-plugins"
  wget https://github.com/christian-korneck/docker-pushrm/releases/download/v1.8.0/docker-pushrm_linux_amd64 -O "$HOME/.docker/cli-plugins/docker-pushrm"
  chmod +rx "$HOME/.docker/cli-plugins/docker-pushrm"
  echo "616339685a474cf5739f4bc5961cdc822e32de2a3c71621a7de32001257da292  $HOME/.docker/cli-plugins/docker-pushrm" | sha256sum -c -w
fi
docker build --pull ${BUILD_ARGS} -t "${CI_REGISTRY_IMAGE}:${TAG}" -f "${FILE}" .
if [ -e test.sh ]; then
  ./test.sh
fi
if [ "${CI_COMMIT_REF_NAME}" = master ]; then
  docker push "${CI_REGISTRY_IMAGE}:${TAG}"
else
  docker save "${CI_REGISTRY_IMAGE}:${TAG}" | gzip > "${TAG}.tgz"
fi
if [ -n "${DOCKER_HUB_PASSWORD}" -a -n "${DOCKER_HUB_USERNAME}" -a "${CI_COMMIT_REF_NAME}" = master ]; then
  docker tag "${CI_REGISTRY_IMAGE}:${TAG}" "tozd/${CI_PROJECT_NAME}:${TAG}"
  docker push "tozd/${CI_PROJECT_NAME}:${TAG}"
  docker pushrm --debug "tozd/${CI_PROJECT_NAME}"
fi
