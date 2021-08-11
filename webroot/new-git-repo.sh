#!/usr/bin/env bash

# we got a new git repo request, verify that git exists
_git_check() {
  if [ -z $(command -v git) ]; then
    echo "git not present, quitting..." >/dev/stderr
    exit $?
  fi
}

# initialize a new git repository at current directory
_initialize_repo() {
  git init
}

# set desired license, if specified
_license() {
  case "$LICENSE" in
    gpl2)
      curl --silent "https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt" -o LICENSE
      ;;
    gpl3)
      curl --silent "https://www.gnu.org/licenses/gpl-3.0.txt" -o LICENSE
      ;;
    mit)
      curl --silent "https://get.bjphoster.com/MIT_LICENSE" -o LICENSE
      ;;
    *)
      echo "invalid or no license provided, using empty file"
      curl --silent "https://get.bjphoster.com/emptyfile" -o LICENSE
  esac
}

# main function, executes everything in the right order
_main() {
  _git_check
  _initialize_repo
  _license
}

# we should actually execute the main function, don't we?
_main
