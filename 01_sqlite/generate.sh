#!/usr/bin/env bash

mkdir -p ./sbom

# TODO: character replacement and add to shell examples
for image in "ubuntu:20.04" "ubuntu:22.04"; 
do
  echo "SBOM for $image"
  docker sbom --format cyclonedx-json $image > ./sbom/$image.json
done

