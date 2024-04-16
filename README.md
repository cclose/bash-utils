# bash-utils
Collection of Bash Utilities for scripting

## docker.sh

### get_docker_executable

Searchs the environment to determine what the docker CLI executable is


## github.sh


### get_latest_github_release

Function to get the latest release tag from a GitHub repo


### check_github_release

Checks if the specified release exists for the specified github repo
  return 0  Release exists
  return 1  Release does not exist or other error occurred


### get_go_version

Function to get the Go version from go.mod for a specific release of a GitHub repo.
Useful for parsing which version of go you need for a release of a repo
