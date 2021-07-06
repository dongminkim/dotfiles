# .install_functions.sh
# source ./.colors.sh

function install_brew {
    if ! which brew >& /dev/null; then
        echo "${GRN}install${RST} ${BLD}brew${RST}"
        echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

        if [ -x "/opt/homebrew/bin/brew" ]; then
            eval "$( "/opt/homebrew/bin/brew" shellenv )"
        elif [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
            eval "$( /home/linuxbrew/.linuxbrew/bin/brew shellenv )"
        elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
            eval "$( "$HOME/.linuxbrew/bin/brew" shellenv )"
        fi
    else
        echo "${GRN}brew update${RST}"
        brew update
    fi
}

function brew_bundle {
    local brewfile="${1:-Brewfile}"

    if ! brew bundle --help >& /dev/null; then
        echo "${GRN}brew tap${RST} ${BLD}Homebrew/bundle${RST}"
        brew tap Homebrew/bundle
    else
        echo "${BLD}brew bundle${RST} ${GRN}exists${RST}"
    fi

    echo "${GRN}brew bundle${RST} --file=${GRN}${brewfile}${RST}"
    brew bundle --file="$brewfile"
}

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
    if [ -x /usr/local/bin/python3 ]; then
        # force to use pip of python installed with brew
        pip="/usr/local/bin/python3 -m pip"
    else
        pip="python3 -m pip"
    fi

    if ! $pip show -q "$1" > /dev/null; then
        echo "${GRN}pip install${RST} ${BLD}$@${RST}"
        $pip install "${2-$1}"
    else
        echo "${BLD}pip $@${RST} ${GRN}exists${RST}"
    fi
}

