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
* Vim
  * Plugin manager
    * [junegunn/vim-plug](https://github.com/junegunn/vim-plug)
  * Colorschemes
    * [nanotech/jellybeans.vim](https://github.com/nanotech/jellybeans.vim)
    * [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
  * Powerline
    * [Lokaltog/powerline](https://github.com/Lokaltog/powerline)
  * A fancy start screen, shows MRU etc.
    * [mhinz/vim-startify](https://github.com/mhinz/vim-startify)
  * Handle surround chars like ''
    * [tpope/vim-surround](https://github.com/tpope/vim-surround)
  * Handle alignment
    * [junegunn/vim-easy-align](https://github.com/junegunn/vim-easy-align)
  * Visualize undo tree
    * [mbbill/undotree](https://github.com/mbbill/undotree)
  * Git inside Vim
    * [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
  * Gist inside Vim
    * [mattn/webapi-vim](https://github.com/mattn/webapi-vim) 
    * [mattn/gist-vim](https://github.com/mattn/gist-vim)
  * Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
    * [mhinz/vim-signify](https://github.com/mhinz/vim-signify)
  * Awesome syntax checker
    * [scrooloose/syntastic](https://github.com/scrooloose/syntastic)
  * Class outline viewer
    * [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
  * FZF - Fuzzy Finder
    * [junegunn/fzf](https://github.com/junegunn/fzf)
    * [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
  * Syntax
    * [tpope/vim-git](https://github.com/tpope/vim-git)
    * [cakebaker/scss-syntax.vim](https://github.com/cakebaker/scss-syntax.vim)
    * [plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown)
  * Completion (or template)
    * [mattn/emmet-vim](https://github.com/mattn/emmet-vim)
  * Make % match xml tags
    * [edsono/vim-matchit](https://github.com/edsono/vim-matchit)
* dotfiles
  * `._shrc`(for both zsh and bash), `.zshrc`, `.bashrc`, `.profile`, `.inputrc`
  * `.vimrc`(My old `.vimrc` has been rewritten with that of [timss/vimconf](https://github.com/timss/vimconf))
  * `.tmux.conf`
  * `.screenrc`

### Customize more

* Shell rc files with `.os.$(uname -s)` prefix will be loaded
  * `.os.$(uname -s)._shrc`(for both zsh and bash), `.os.$(uname -s).zshrc`, `.os.$(uname -s).bashrc`
    * e.g. `os.Darwin.zshrc` will be loaded in Mac OS X zsh
* Shell rc files with `.host.$(uname -n)` prefix will be loaded
  * `.host.$(uname -n)._shrc`(for both zsh and bash), `.host.$(uname -n).zshrc`, `.host.$(uname -n).bashrc`
    * e.g. `.host.github.com.bashrc` will be loaded in bash at host github.com
* Shell rc files with `.local` prefix will be loaded
  * `.local._shrc`(for both zsh and bash), `.local.zshrc`, `.local.bashrc`
* Screen rc files with `.host.$(uname -n)` prefix will be loaded
  * `.host.$(uname -n).screenrc`
    * e.g. `.host.github.com.screenrc` will be used when run screen at host github.com
* Vim rc files with `.local` prefix will be loaded
  * `.local.plugins.vimrc` will be loaded in Vundle's loading step
  * `.local.pre.vimrc` will be loaded just before the main .vimrc settings and just after vim-plug loading step
  * `.local.vimrc` will be loaded after the main .vimrc settings

## Author

* [@dongminkim](https://github.com/dongminkim)
  * `vanity` is my account ID
  * `diego` is my nickname in my company

