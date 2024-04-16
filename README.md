# bash-utils
Collection of Bash Utilities for scripting

## docker.sh

### docker_get_executable

Searchs the environment to determine what the docker CLI executable is

### docker_get_semantic_versions

Retrieves SemVer tags from a docker hub repo

### docker_is_latest_version

Compares if provided tag is a newer SemVer than
existing SemVer tags in a docker repo. If param 3, current_version,
isn't a SemVer, will return false


## github.sh


### github_get_latest_release

Function to get the latest release tag from a GitHub repo


### github_check_release

Checks if the specified release exists for the specified github repo
  return 0  Release exists
  return 1  Release does not exist or other error occurred


### github_get_repo_go_version

Function to get the Go version from go.mod for a specific release of a GitHub repo.
Useful for parsing which version of go you need for a release of a repo
