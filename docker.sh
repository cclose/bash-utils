#!/bin/bash

# docker_get_executable
#
# Function to determine the Docker executable. Works with
# - podman
# - nerdctl
# - docker
# Defaults to docker, but prefers podman -> nerdctl -> docker
docker_get_executable() {
    local docker_executable

    if command -v podman &>/dev/null; then
        docker_executable="podman"
    elif command -v nerdctl &>/dev/null; then
        docker_executable="nerdctl"
    elif command -v docker &>/dev/null; then
        docker_executable="docker"
    else
        docker_executable="docker" # Default to docker
    fi

    echo "$docker_executable"
}
