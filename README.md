# Vanity.dump(dotfiles)

![Screenshot](https://cloud.githubusercontent.com/assets/1652790/14531193/4d389e0a-0297-11e6-9158-f6780b86b385.png)
Screenshot captured in iTerm2 with `Vanity Dark` Profile

## Installation

**Warning:** Use at your own risk!

### Using Git and the bootstrap script

1. You can clone the repository wherever you want, and run the bootstrap script.
  ```bash
git clone https://github.com/dongminkim/dotfiles.git ~/.dotfiles && ~/.dotfiles/bootstrap.sh
  ```

1. You may be asked your password to do `sudo` once or twice.

1. And after oh-my-zsh installed, in order to continue to the next steps, you should type `exit` in oh-my-zsh interactive shell prompt.

1. When the bootstrap script finishes, you can see the instructions how to load iTerm2 profiles.

1. Then run `vim` to install Vim Plugins.  It will automatically install plugins with Vundle.

That's it!

### What will be installed?

* Mac OS X
  * [Homebrew](http://brew.sh)
  * [iTerm2](https://iterm2.com)
    * iTerm2 Profiles & color presets [Vanity](https://github.com/dongminkim/vanity)
  * [tmux](https://tmux.github.io)
    * [tmux-MacOSX-pasteboard](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) aka reattach-to-user-namespace
* zsh
  * [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [agnoster theme](https://gist.github.com/agnoster/3712874)
  * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [Powerline](https://github.com/powerline/powerline)
  * [Powerline fonts](https://github.com/powerline/fonts)
* vim
  * [Vundle](https://github.com/VundleVim/Vundle.vim)
    * [chrisbra/SudoEdit.vim](http://github.com/chrisbra/SudoEdit.vim)
    * [ervandew/supertab](http://github.com/ervandew/supertab)
    * [ctrlpvim/ctrlp.vim](http://github.com/ctrlpvim/ctrlp.vim)
    * [bling/vim-bufferline](http://github.com/bling/vim-bufferline)
    * [nanotech/jellybeans.vim](http://github.com/nanotech/jellybeans.vim)
    * [altercation/vim-colors-solarized](http://github.com/altercation/vim-colors-solarized)
    * [scrooloose/nerdcommenter](http://github.com/scrooloose/nerdcommenter)
    * [somini/vim-autoclose](http://github.com/somini/vim-autoclose)
    * [tpope/vim-fugitive](http://github.com/tpope/vim-fugitive)
    * [tpope/vim-surround](http://github.com/tpope/vim-surround)
    * [vim-scripts/Align](http://github.com/vim-scripts/Align)
    * [MarcWeber/vim-addon-mw-utils](http://github.com/MarcWeber/vim-addon-mw-utils)
    * [tomtom/tlib_vim](http://github.com/tomtom/tlib_vim)
    * [honza/vim-snippets](http://github.com/honza/vim-snippets)
    * [garbas/vim-snipmate](http://github.com/garbas/vim-snipmate)
    * [mhinz/vim-startify](http://github.com/mhinz/vim-startify)
    * [mhinz/vim-signify](http://github.com/mhinz/vim-signify)
    * [scrooloose/syntastic](http://github.com/scrooloose/syntastic)
    * [majutsushi/tagbar](http://github.com/majutsushi/tagbar)
    * [Lokaltog/powerline](http://github.com/Lokaltog/powerline)
* dotfiles
  * `._shrc`(for both zsh and bash), `.zshrc`, `.bashrc`, `.profile`, `.inputrc`
  * `.vimrc`
  * `.tmux.conf`
  * `.screenrc`

### Customize more

* Shell rc files with `.os.$(uname -s)` prefix will be loaded
  * `.os.$(uname -s)._shrc`(for both zsh and bash), `.os.$(uname -s).zshrc`, `.os.$(uname -s).bashrc`
    * e.g. `os.Darwin.zshrc` will be loaded in Mac OS X zsh
* Shell rc files with `.host.$(uname -n)` prefix will be loaded
  * `.host.$(uname -n)._shrc`(for both zsh and bash), `.host.$(uname -n).zshrc`, `.host.$(uname -n).bashrc`
    * e.g. `host.github.com.bashrc` will be loaded in bash at host github.com
* Shell rc files with `.local` prefix will be loaded
  * `.local._shrc`(for both zsh and bash), `.local.zshrc`, `.local.bashrc`
* Screen rc files with `.host.$(uname -n)` prefix will be loaded
  * `.host.$(uname -n).screenrc`
    * e.g. `host.github.com.screenrc` will be used when run screen at host github.com
* Vim rc files with `.local` prefix will be loaded
  * `.local.plugins.vimrc` will be loaded in Vundle's loading step
  * `.local.pre.vimrc` will be loaded just before the main .vimrc settings and just after Vundle loading step
  * `.local.vimrc` will be loaded after the main .vimrc settings

## Author
* [@dongminkim](https://github.com/dongminkim)
* `vanity` is my account ID
* `diego` is my nickname in my company

## Thanks to...
 * [@timss](https://github.com/timss) - `.vimrc` is originated from [timss/vimconf](https://github.com/timss/vimconf)
