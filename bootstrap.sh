#!/bin/bash
# boostrap.sh

cd "$( dirname "${BASH_SOURCE[0]}" )"
OS="$(uname -s)"

# colors
    DEF=$(echo -en '\033[39m')
    BLK=$(echo -en '\033[30m')
    RED=$(echo -en '\033[31m')
    GRN=$(echo -en '\033[32m')
    YLW=$(echo -en '\033[33m')
    BLU=$(echo -en '\033[34m')
    MGT=$(echo -en '\033[35m')
    CYN=$(echo -en '\033[36m')
    LGRY=$(echo -en '\033[37m')
    DGRY=$(echo -en '\033[90m')
    LRED=$(echo -en '\033[91m')
    LGRN=$(echo -en '\033[92m')
    LYLW=$(echo -en '\033[93m')
    LBLU=$(echo -en '\033[94m')
    LMGT=$(echo -en '\033[95m')
    LCYN=$(echo -en '\033[96m')
    WHT=$(echo -en '\033[97m')
    ORNG=$(echo -en '\033[38;5;166m')
    RST=$(echo -en '\033[00m')
    BLD=$(echo -en '\033[1;2m')
    RBLD=$(echo -en '\033[21;22m')
    UND=$(echo -en '\033[4m')
    RUND=$(echo -en '\033[24m')

# install functions
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
    function osx_prerequisites {
        # brew
            if ! which brew >& /dev/null; then
                echo "${GRN}install${RST} ${BLD}brew${RST}"
                ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            else
                echo "${BLD}brew${RST} ${GRN}exists${RST}"
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
            echo "${GRN}brew bundle${RST}"
            brew bundle

        # Xcode CLI Tools
            echo "${GRN}install${RST} ${BLD}Xcode CLI${RST}"
            xcode-select --install >& /dev/null

        # enable python pip install without sudo
            py_pkg_dir=/Library/Python/2.7/site-packages
            if ! touch "$py_pkg_dir/_" >& /dev/null; then
                echo "${GRN}chmod${RST} ${BLD}${py_pkg_dir}${RST}"
                sudo chmod -R +a "user:$USER allow add_subdirectory,add_file,delete_child,directory_inherit" "$py_pkg_dir"
            else
                echo "${BLD}${py_pkg_dir}${RST} ${GRN}ACL exists${RST}"
            fi
    }

# install
    [[ "$OS" == "Darwin" ]] && osx_prerequisites

# install powerline
    pip_install powerline-status
    pip_install psutil
    pip_install bzr
    pip_install mercurial

# install oh-my-zsh
    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        echo "${GRN}install${RST} ${BLD}oh-my-zsh${RST}"
        echo "${MGT}[!] Once oh-my-zsh is installed, type ${UND}exit${RUND} to continue${RST}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echo "${GRN}install${RST} ${BLD}zsh-syntax-highlighting${RST}"
        zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
    else
        echo "${BLD}oh-my-zsh${RST} ${GRN}exists${RST}"
    fi

# copy dot files
    echo "${GRN}copy${RST} ${BLD}dot files${RST}"
    dotfiles=($( find . -depth 1 -type f -iname '.*' -not -iname '.gitignore' ))
    for fn in "${dotfiles[@]}"; do
        src_fn="${fn#./}"
        dst_fn="$HOME/$src_fn"
        if [ -f "$dst_fn" ]; then
            mv "$dst_fn" "$dst_fn.bak"
        fi
        echo "${GRN}cp${RST} \"${BLD}${src_fn}${RST}\" \"$HOME/\""
        cp "$src_fn" "$HOME/"
    done

# install powerline fonts
    fontdir=ext/fonts
    if [ ! -d "$fontdir" ]; then
        echo "${GRN}install${RST} ${BLD}powerline fonts${RST}"
        git clone https://github.com/powerline/fonts.git "$fontdir"
        cd "$fontdir"
        ./install.sh
        cd -
    else
        echo "${BLD}powerline fonts${RST} ${GRN}exists${RST}"
    fi

# install iTerm profiles & color presets
    if [[ "$OS" == "Darwin" ]]; then
        vdir=ext/vanity
        if [ ! -d "$vdir" ]; then
            echo "${GRN}install${RST} ${BLD}iTerm profiles & color presets${RST}"
            git clone https://github.com/dongminkim/vanity.git "$vdir"

            echo "${MGT}[!] Open iTerm and load preferences${RST}"
            echo "${BLD}iTerm > Preferences > General > (at bottom) Load preferences${RST}"
            echo "${MGT}input:${RST} ${BLD}$PWD/$vdir/iTerm2${RST}"
            open -a iTerm >& /dev/null
        else
            echo "${BLD}iTerm profiles & color presets${RST} ${GRN}exists${RST}"
        fi
    fi

echo "${GRN}done${RST}"
