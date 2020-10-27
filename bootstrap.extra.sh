#!/bin/bash
# boostrap.extra.sh
# This script assumes that boostrap.sh is already executed.

cd "$( dirname "${BASH_SOURCE[0]}" )"
OS="$(uname -s)"

source ./.colors.sh
source ./.install_functions.sh


function install_rvm {
    if ! which rvm >& /dev/null; then
        echo "${GRN}install${RST} ${BLD}rvm${RST}"
        grep '\<gem:\s*--no-document/>' "$HOME/.gemrc" > /dev/null || echo "gem: --no-document" >> "$HOME/.gemrc"
        curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --rails
    else
        echo "${BLD}rvm${RST} ${GRN}exists${RST}"
    fi
}


brew_bundle Brewfile.extra
install_rvm && gem_install bundler


echo "${GRN}done${RST}"
