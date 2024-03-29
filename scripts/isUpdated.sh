#!/bin/bash

set -e

retrieve_latest_release () {
    repo=$1

    local version=$(curl -s \
                -H "Accept: application/json" \
                https://api.github.com/repos/$repo/releases | \
                    jq -r '.[] | select(.prerelease==false and .draft==false) | .tag_name' | \
                    grep -Po '(\d+\.)?(\d+\.)?(\*|\d+)$' | \
                    sort -n -r | \
                    head -n1)
    echo $version
}

echo "********** DEBUG **********"
repo='gabrie30/ghorg'
echo $(curl -s \
                -H "Accept: application/json" \
                https://api.github.com/repos/$repo/releases | \
                    jq -r '.[] | select(.prerelease==false and .draft==false) | .tag_name')
echo "---------------------------"
echo $(curl -s \
                -H "Accept: application/json" \
                https://api.github.com/repos/$repo/releases | \
                    jq -r '.[] | select(.prerelease==false and .draft==false) | .tag_name' | \
                    grep -Po '(\d+\.)?(\d+\.)?(\*|\d+)$' | \
                    sort -n -r | \
                    head -n1)
echo "***************************"

ext_tag=$(retrieve_latest_release 'gabrie30/ghorg')
ext_tag_len=$(echo $ext_tag |awk '{print length}')

echo "**** External release is $ext_tag"

last_tag=$(retrieve_latest_release 'afonsoc12/docker-ghorg')

echo "**** Last release is $last_tag"

if [ -z "${ext_tag}" ] || [ "${ext_tag}" == "null" ]; then
    echo "**** Can't retrieve external release, exiting... ****"
    exit 1
elif [ "$ext_tag" == "$last_tag" ] && [ "$ext_tag_len" -lt 15 ]; then
    echo "**** Current release is still up-to-date ****"
    echo "    - ghorg version:  $ext_tag"
    echo "    - Last release version: $last_tag"
elif [ "$ext_tag_len" -lt 15 ]; then
    version_file="DOCKER_VERSION.txt"
    echo "**** Triggering new release by creating the file: $version_file ****"
    echo "    Old version: $last_tag"
    echo "    NEW version: $ext_tag"
    echo $ext_tag > $version_file
else
    echo "**** Other error occurred ****"
fi
