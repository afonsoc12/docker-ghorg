# Docker ghorg

[![Docker Pulls](https://img.shields.io/docker/pulls/afonsoc12/ghorg?logo=docker)](https://hub.docker.com/repository/docker/afonsoc12/ghorg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

[![Github Starts](https://img.shields.io/github/stars/afonsoc12/docker-ghorg?logo=github)](https://github.com/afonsoc12/docker-ghorg)
[![Github Fork](https://img.shields.io/github/forks/afonsoc12/docker-ghorg?logo=github)](https://github.com/afonsoc12/docker-ghorg)
[![Github Release](https://img.shields.io/github/v/release/afonsoc12/docker-ghorg?logo=github)](https://github.com/afonsoc12/docker-ghorg/releases)

> Note: This project is now archived as I have migrated this to the original repo.
> For more information, please check [this issue](https://github.com/gabrie30/ghorg/issues/351).

[ghorg](https://github.com/gabrie30/ghorg) is a CLI tool designed to *"quickly clone an entire org/users repositories into one directory"*.

This repository automatically builds and pushes docker images for the latest releases of [gabrie30/ghorg](https://github.com/gabrie30/ghorg). It is based on the lightweight [alpine](https://hub.docker.com/_/alpine) image, built for `linux/amd64`, `linux/arm64` and `linux/arm/v7` architectures.

# Instalation

The image can be pulled from both [DockerHub](https://hub.docker.com/r/afonsoc12/ghorg) and [ghcr.io](https://github.com/afonsoc12/docker-ghorg/pkgs/container/ghorg) container registries.

```shell
# You can also specify a version as the tag, such as afonsoc12/ghorg:1.5.0
docker pull afonsoc12/ghorg:latest

# Should print help message
docker run --rm afonsoc12/ghorg
```

The commands for ghorg are parsed as docker commands. The entrypoint is `ghorg` executable, hence you only need to enter remaining arguments as follows:

```shell
docker run --rm afonsoc12/ghorg clone kubernetes --token=<API_TOKEN>
```

## Usage

```shell
docker run --rm \
        -e GHORG_GITHUB_TOKEN=<API_TOKEN> \
        -v $HOME/.config/ghorg:/config `#optional` \
        -v $HOME/repositories:/data \
        afonsoc12/ghorg:latest \
        clone kubernetes
```

A shell alias might make this more practical:

```shell
alias ghorg="docker run --rm -v $HOME/.config/ghorg:/config -v $HOME/repositories:/data afonsoc12/ghorg:latest"
```

## Configuration

By default, ghorg expects configuration file to be at `$HOME/.config/ghorg/conf.yaml`. However, this container sets a few environment variables by default, so the location of this file should instead be `/config/conf.yaml` inside the container. You can override these as you please:

| Variable | Container default |
| :----: | --- |
| `GHORG_CONFIG` | `/config/conf.yaml` |
| `GHORG_RECLONE_PATH` | `/config/reclone.yaml` |
| `GHORG_ABSOLUTE_PATH_TO_CLONE_TO` | `/data` |

You may set [any other environment variable](https://github.com/gabrie30/ghorg/blob/master/sample-conf.yaml) that ghorg expects or edit the configuration file.

Sample [`config.yaml`](https://github.com/gabrie30/ghorg/blob/master/sample-conf.yaml) and [`reclone.yaml`](https://github.com/gabrie30/ghorg/blob/master/sample-reclone.yaml) files are added to `/config` folder, but do not interfere with normal operation, unless they are changed.

For more information, please consult [the documentation](https://github.com/gabrie30/ghorg#readme) on [ghorg's repository](https://github.com/gabrie30/ghorg).


## Credits

Copyright 2022 Afonso Costa

Licensed under the [Apache License, Version 2.0](https://github.com/afonsoc12/docker-ghorg/blob/master/LICENSE) (the "License")
