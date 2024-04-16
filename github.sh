#!/bin/bash

GITHUB_API_URL="https://api.github.com"

# get_latest_github_release
#
# Function to get the latest release tag from a GitHub repo
get_latest_github_release() {
    local owner="$1"
    local repo="$2"
    local auth=""
    local latest_release=$(curl -sSL \
      -H "Accept: application/vnd.github+json" \
      $auth \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "${GITHUB_API_URL}/repos/$owner/$repo/releases/latest" | jq -r '.tag_name')
    echo "$latest_release"
}

# check_github_release
#
# Checks if the specified release exists for the specified github repo
check_github_release() {
    local owner="$1"
    local repo="$2"
    local tag="$3"
    local auth=""
    local http_code=$(curl -sL -o /dev/null -w "%{http_code}" \
      -H "Accept: application/vnd.github+json" \
      $auth \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "${GITHUB_API_URL}/repos/$owner/$repo/releases/tags/$tag")

    if [ "$http_code" = "200" ]; then
        return 0  # Release exists
    else
        return 1  # Release does not exist or other error occurred
    fi
}

# get_go_version
#
# Function to get the Go version from go.mod for a specific release of a GitHub repo.
# Useful for parsing which version of go you need for a release of a repo
get_github_repo_go_version() {
    local repo="$1"
    local release_tag="$2"
    local go_version=$(curl -sSL "https://raw.githubusercontent.com/$repo/$release_tag/go.mod" | grep -E '^go[[:space:]]+[0-9]+\.[0-9]+')
    echo "$go_version" | cut -d ' ' -f2
}
