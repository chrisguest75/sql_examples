#!/usr/bin/env bash

# TODO:
# * force recreate
# * skip sbom

_basepath=./data
mkdir -p ${_basepath}

# TODO: character replacement and add to shell examples
for image in "ubuntu:20.04" "ubuntu:22.04"; 
do
    echo "SBOM for $image"
    _outfile="${image//:/}"
    docker sbom --format cyclonedx-json $image > ${_basepath}/$_outfile.json

    #jq -cr '["Name", "Type"], (. | [.metadata.component.name, .metadata.component.type]) | @csv' ./sbom/$_outfile.json > ${_basepath}/${_outfile}.csv 
    #jq -cr '["Type","Name","Version"], (.components[] | [.type, .name, .version]) | @csv' ./sbom/$_outfile.json > ${_basepath}/${_outfile}_components.csv 

    jq -r '[(. | { "name": .metadata.component.name, "type": .metadata.component.type})]' ${_basepath}/${_outfile}.json > ${_basepath}/${_outfile}_images.json
    jq -r '[(.components[] | { "type": .type, "name": .name, "version": .version})]' ${_basepath}/${_outfile}.json > ${_basepath}/${_outfile}_components.json
done

