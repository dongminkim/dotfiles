# .install_functions.sh
# source ./.colors.sh

function brew_install {
    if ! brew list "$@" >& /dev/null; then
        echo "${GRN}brew install${RST} ${BLD}$@${RST}"
        brew install "$@"
    else
        echo "${BLD}brew $@${RST} ${GRN}exists${RST}"
    fi
}

function brew_cask_install {
    if ! brew cask list "$@" >& /dev/null; then
        echo "${GRN}brew cask install${RST} ${BLD}$@${RST}"
        brew cask install "$@"
    else
        echo "${BLD}brew cask $@${RST} ${GRN}exists${RST}"
    fi
}

function npm_install {
    if ! npm ls "$@" >& /dev/null; then
        echo "${GRN}npm install${RST} ${BLD}$@${RST}"
        npm install "$@"
    else
        echo "${BLD}npm $@${RST} ${GRN}exists${RST}"
    fi
}

function gem_install {
    if ! gem list -i "$@" > /dev/null; then
        echo "${GRN}gem install${RST} ${BLD}$@${RST}"
        gem install "$@" || { echo "${RED}Oops! Try again with sudo...${RST}"; sudo gem install "$@"; }
    else
        echo "${BLD}gem $@${RST} ${GRN}exists${RST}"
    fi
}

function pip_install {
    if [ -x /usr/local/bin/python ]; then
        # force to use pip of python installed with brew
        pip="/usr/local/bin/python -m pip"
    else
        pip="python -m pip"
    fi

    if ! $pip show -q "$1" > /dev/null; then
        echo "${GRN}pip install${RST} ${BLD}$@${RST}"
        $pip install "${2-$1}"
    else
        echo "${BLD}pip $@${RST} ${GRN}exists${RST}"
    fi
}

