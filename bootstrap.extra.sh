#!/bin/bash
# boostrap.extra.sh
# This script assumes that boostrap.sh is already executed.

cd "$( dirname "${BASH_SOURCE[0]}" )"
OS="$(uname -s)"

source ./.colors.sh
source ./.install_functions.sh


brew_bundle Brewfile.extra
install_rvm && gem_install bundler


echo "${GRN}done${RST}"
