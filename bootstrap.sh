#!/bin/bash
# boostrap.sh

cd "$( dirname "${BASH_SOURCE[0]}" )"
OS="$(uname -s)"

source ./.colors.sh
source ./.install_functions.sh


function install_macOS_prerequisites {
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

function setup_fzf {
    # fzf key bindings & fuzzy completion
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
}

function install_ohMyZsh {
    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        echo "${GRN}install${RST} ${BLD}oh-my-zsh${RST}"
        echo "${MGT}[!] Once oh-my-zsh is installed, type ${UND}exit${RUND} to continue${RST}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    else
        echo "${BLD}oh-my-zsh${RST} ${GRN}exists${RST}"
    fi

    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        echo "${GRN}install${RST} oh-my-zsh plugin ${BLD}zsh-syntax-highlighting${RST}"
        zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
    else
        echo "oh-my-zsh plugin ${BLD}zsh-syntax-highlighting${RST} ${GRN}exists${RST}"
    fi

    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        echo "${GRN}install${RST} oh-my-zsh theme ${BLD}powerlevel10k${RST}"
        zsh -c 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k'
    else
        echo "oh-my-zsh theme ${BLD}powerlevel10k${RST} ${GRN}exists${RST}"
    fi
}

function install_vimPlugins {
    echo "${GRN}install${RST} ${BLD}Vim plugins${RST}"
    vim -u './.vimrc' -c 'PlugUpdate' -c 'qa'
}

function install_dotfiles {
    echo "${GRN}copy${RST} ${BLD}dot files${RST}"
    date="$( date '+%Y-%m-%dT%H:%M:%S' )"
    dotfiles=($( find . -maxdepth 1 -type f -iname '.*' -not -iname '.gitignore' ))
    for fn in "${dotfiles[@]}"; do
        src_fn="${fn#./}"
        dst_fn="$HOME/$src_fn"
        if [ -f "$dst_fn" ]; then
            mv "$dst_fn" "$dst_fn.$date.bak"
        fi
        echo "${GRN}cp${RST} \"${BLD}${src_fn}${RST}\" \"$HOME/\""
        cp "$src_fn" "$HOME/"
    done
}

function setup_macOS_terminalEnvironment {
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
        else
            echo "${BLD}iTerm profiles & color presets${RST} ${GRN}exists${RST}"
        fi

        echo "${MGT}[!] Open iTerm and load preferences${RST}"
        echo "1. iTerm > Preferences > Profiles > (at bottom) Other Actions... > ${MGT}Import JSON Profiles...${RST}"
        echo "2. Choose ${MGT}\"$PWD/$vdir/iTerm2/Vanity Profiles.json\"${RST}"
        echo "3. Click ${MGT}Vanity Dark${RST} or ${MGT}Vanity Light${RST}"
        echo "4. iTerm > Preferences > Profiles > (at bottom) Other Actions... > ${MGT}Set as Default${RST}"
        echo "5. Restart iTerm"
        open -a iTerm >& /dev/null
    fi
}

[[ "$OS" == "Darwin" ]] && install_macOS_prerequisites
install_brew
brew_bundle
[[ -f "Brewfile.$OS" ]] && brew_bundle "Brewfile.$OS"
setup_fzf
install_ohMyZsh
install_vimPlugins
install_dotfiles
[[ "$OS" == "Darwin" ]] && setup_macOS_terminalEnvironment


echo "${GRN}done${RST}"
