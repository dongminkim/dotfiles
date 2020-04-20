#!/bin/bash
# boostrap.sh

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
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
            else
                echo "${GRN}brew update${RST}"
                brew update
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

        # fzf key bindings & fuzzy completion
            $(brew --prefix)/opt/fzf/install

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

# install oh-my-zsh
    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        echo "${GRN}install${RST} ${BLD}oh-my-zsh${RST}"
        echo "${MGT}[!] Once oh-my-zsh is installed, type ${UND}exit${RUND} to continue${RST}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echo "${GRN}install${RST} ${BLD}zsh-syntax-highlighting${RST}"
        zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'

        echo "${GRN}install${RST} ${BLD}powerlevel10k${RST}"
        zsh -c 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k'
    else
        echo "${BLD}oh-my-zsh${RST} ${GRN}exists${RST}"
    fi

# install Vim plugins
    echo "${GRN}install${RST} ${BLD}Vim plugins${RST}"
    vim -u './.vimrc' -c 'PlugUpdate' -c 'qa'

# copy dot files
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
        echo "${BLD}iTerm > Preferences > General > (at bottom) Load preferences${RST}"
        echo "${MGT}input:${RST} ${BLD}$PWD/$vdir/iTerm2${RST}"
        open -a iTerm >& /dev/null
    fi

echo "${GRN}done${RST}"
