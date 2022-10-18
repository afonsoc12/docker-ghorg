#!/bin/bash

echo "**** Cloning $git_url branch master with depth 1"
git_url="https://github.com/gabrie30/ghorg"
git clone --branch $1 --depth 1 $git_url

echo "**** Repository gabrie30/ghorg successfully cloned!"

cp Dockerfile ghorg
echo "**** Replaced Dockerfile ****"
