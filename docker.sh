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

# docker_get_semantic_versions
#
# Function to retrieve SemVer tags from a docker hub repo
docker_get_semantic_versions() {
    local namespace="$1"
    local image="$2"

    local tags=$(curl -sSL "https://hub.docker.com/v2/repositories/$namespace/$image/tags/" | jq -r '.results[].name') 
    local sem_tags=$(echo "$tags" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | uniq | sort -V)
    echo "$sem_tags"
}

# docker_is_latest_version
#
# Function to compare if provided tag is a newer SemVer than
# existing SemVer tags in a docker repo. If param 3, current_version,
# isn't a SemVer, will return false
docker_is_latest_version() {
    local namespace="$1"
    local image="$2"
    local current_version="$3"
    current_version=${current_version#v}

    if echo "$current_version" | grep -Evoq '[0-9]+\.[0-9]+\.[0-9]+' ; then
       return 1
    fi

    local existing_versions=$(docker_get_semantic_versions "$namespace" "$image")
    printf '%s\n' "$existing_versions" "$current_version" | sort -C -V
}
