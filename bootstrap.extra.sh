#!/bin/bash
# boostrap.extra.sh
# This script assumes that boostrap.sh is already executed.

cd "$( dirname "${BASH_SOURCE[0]}" )"
OS="$(uname -s)"

# colors
    source ./.colors.sh
    source ./.install_functions.sh

# install functions
    function osx_prerequisites {
        # brew
            if ! which brew >& /dev/null; then
                echo "${GRN}install${RST} ${BLD}brew${RST}"
                ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            else
                echo "${GRN}brew update${RST}"
                brew update
            fi

        # brew cask
            if ! brew cask >& /dev/null; then
                echo "${GRN}brew tap${RST} ${BLD}caskroom/cask${RST}"
                brew tap caskroom/cask
            else
                echo "${BLD}brew cask${RST} ${GRN}exists${RST}"
            fi

        # brew bundle
            if ! brew bundle >& /dev/null; then
                echo "${GRN}brew tap${RST} ${BLD}Homebrew/bundle${RST}"
                brew tap Homebrew/bundle
            else
                echo "${BLD}brew bundle${RST} ${GRN}exists${RST}"
            fi
            echo "${GRN}brew bundle${RST} --file=${GRN}Brewfile.extra${RST}"
            brew bundle --file=Brewfile.extra
    }

# install
    [[ "$OS" == "Darwin" ]] && osx_prerequisites

# install rvm
    if ! which rvm >& /dev/null; then
        echo "${GRN}install${RST} ${BLD}rvm${RST}"
        grep '\<gem:\s*--no-document/>' "$HOME/.gemrc" > /dev/null || echo "gem: --no-document" >> "$HOME/.gemrc"
        curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --rails
    else
        echo "${BLD}rvm${RST} ${GRN}exists${RST}"
    fi

# install gems
    gem_install bundler

echo "${GRN}done${RST}"
