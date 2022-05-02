#!/usr/bin/env bash

# TODO:
# * force recreate
# * skip sbom

_basepath=./data
mkdir -p ${_basepath}

function trim() {
    : ${1?"${FUNCNAME[0]}(string) - missing string argument"}

    if [[ -z ${1} ]]; then 
        echo ""
        return
    fi
    # remove an 
    trimmed=${1##*( )}
    echo ${trimmed%%*( )}
}

readarray images < <(jq -r '.images[]' ./images.json)
echo "${images[1]}"

for image in "${images[@]}"; 
do
    image=$(trim $image)
    echo "SBOM for $image"
    _outfile="${image//:/}"
    docker sbom --format cyclonedx-json $image > ${_basepath}/$_outfile.json

    #jq -cr '["Name", "Type"], (. | [.metadata.component.name, .metadata.component.type]) | @csv' ./sbom/$_outfile.json > ${_basepath}/${_outfile}.csv 
    #jq -cr '["Type","Name","Version"], (.components[] | [.type, .name, .version]) | @csv' ./sbom/$_outfile.json > ${_basepath}/${_outfile}_components.csv 

    #jq -r '[(. | { "name": .metadata.component.name, "type": .metadata.component.type})]' ${_basepath}/${_outfile}.json > ${_basepath}/${_outfile}_images.json
    #jq -r '[(.components[] | { "type": .type, "name": .name, "version": .version})]' ${_basepath}/${_outfile}.json > ${_basepath}/${_outfile}_components.json
done

