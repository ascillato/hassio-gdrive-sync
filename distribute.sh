#!/bin/bash
set -ev

if [ ! -z ${TRAVIS_TAG} ]; then
    echo "Tagged build found. Pushing to Docker with tag 'latest'."
else
    echo "No tag found. Pushing to Docker with tag 'test'."
fi

docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
docker run -it --rm --privileged --name "${ADDON_NAME}" \
    -v ~/.docker:/root/.docker \
    -v "$(pwd)":/docker \
    hassioaddons/build-env:latest \
    --target "${ADDON_NAME}" \
    --git \
    --all \
    --push \
    --from "homeassistant/{arch}-base" \
    --author "Daniel Welch <dwelch2102@gmail.com>" \
    --doc-url "${GITHUB_URL}"

