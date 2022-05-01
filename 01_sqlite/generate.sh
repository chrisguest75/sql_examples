#!/usr/bin/env bash

mkdir -p ./sbom

# TODO: character replacement and add to shell examples
for image in "ubuntu:20.04" "ubuntu:22.04"; 
do
    echo "SBOM for $image"
    _outfile="${image//:/}"
    #docker sbom --format cyclonedx-json $image > ./sbom/$_outfile.json

    jq -cr ". | [.metadata.component.name, .metadata.component.type] | @csv" ./sbom/$_outfile.json > ./sbom/$_outfile.csv 
    jq -cr ".components[] | [.type, .name, .version] | @csv" ./sbom/$_outfile.json > ./sbom/${_outfile}_components.csv 
done

