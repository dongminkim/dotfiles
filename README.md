**A collection of dotfiles for developers using macOS and Linux.**

![screenshot](https://user-images.githubusercontent.com/1652790/82305027-174bbc80-99f8-11ea-8a6d-b66efaa855ff.png)
Screenshot captured in iTerm2 with `Vanity Dark` Profile

## Installation

**Warning:** Use at your own risk!

### Using Git and the bootstrap script

1. You can clone the repository wherever you want, and run the bootstrap script.
    ```sh
    git clone https://github.com/dongminkim/dotfiles.git ~/.dotfiles && ~/.dotfiles/bootstrap.sh
    ```

1. You may be asked your password to do `sudo` once or twice.

1. And after **oh-my-zsh** installed, in order to continue to the next steps, you should type `exit` in **oh-my-zsh** interactive shell prompt.

1. When the bootstrap script finishes, you can see the **instructions** how to load **iTerm2** profiles.

1. Quit and restart **iTerm2**.

That's it!

### What will be installed?

* OS Specific
    * macOS(Mac OS X)
        * [Homebrew](http://brew.sh)
            * [coreutils](https://formulae.brew.sh/formula/coreutils), [wget](https://formulae.brew.sh/formula/wget), [openssl](https://formulae.brew.sh/formula/openssl@3), [trash](https://formulae.brew.sh/formula/trash), [reattach-to-user-namespace](https://formulae.brew.sh/formula/reattach-to-user-namespace), [the_silver_searcher (ag)](https://formulae.brew.sh/formula/the_silver_searcher)
        * [iTerm2](https://iterm2.com)
            * iTerm2 Profiles & color presets [Vanity](https://github.com/dongminkim/vanity)
    * Linux
        * [Homebrew on Linux(linuxbrew)](https://docs.brew.sh/Homebrew-on-Linux)
* Terminal & Shell
    * [zsh](https://www.zsh.org)
        * [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
        * [Powerlevel10k theme](https://github.com/romkatv/powerlevel10k)
        * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
        * [zsh-interactive-cd](https://github.com/changyuheng/zsh-interactive-cd)
    * [tmux](https://tmux.github.io) - a terminal multiplexer
    * [Vim](https://www.vim.org) - the editor
    * Languages
        * [python](https://www.python.org)
        * [nvm](https://github.com/nvm-sh/nvm) - [Node.js](https://nodejs.org/) version manager
    * [fd](https://github.com/sharkdp/fd) - an alternative to `find`
    * [fzf](https://github.com/junegunn/fzf) - a general-purpose command-line fuzzy finder
        * will be installed via Homebrew
        * FYI, you may want to take a look at [fzf Examples](https://github.com/junegunn/fzf/wiki/Examples)
    * [fasd](https://github.com/clvv/fasd) - offers quick access to files and directories for POSIX shells
    * [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) - a line-oriented search tool that recursively searches the current directory for a regex pattern
    * [bat](https://github.com/sharkdp/bat) - a cat clone with syntax highlighting and git integration
    * [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) - an alternative to `diff`
    * [tldr](https://github.com/tldr-pages/tldr) - a collection of community-maintained help pages for command-line tools
    * [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) - provides a set of functions for use by applications that allow users to edit command lines as they are typed in
    * dotfiles
        * `._shrc`(for both zsh and bash), `.zshrc`, `.bashrc`, `.profile`, `.inputrc`
        * `.vimrc`(my old `.vimrc` has been rewritten with that of [timss/vimconf](https://github.com/timss/vimconf))
        * `.tmux.conf`
        * `.screenrc`
* Vim
    * [junegunn/vim-plug](https://github.com/junegunn/vim-plug) - a vim plugin manager
    * colorschemes
        * [nanotech/jellybeans.vim](https://github.com/nanotech/jellybeans.vim)
        * [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
    * status line
        * [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
        * [edkolev/tmuxline.vim](https://github.com/edkolev/tmuxline.vim)
    * [mhinz/vim-startify](https://github.com/mhinz/vim-startify) - a fancy start screen
    * [tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired) - pairs of handy bracket mappings, [(more...)](https://noahfrederick.com/log/a-list-of-vims-lists)
    * [tpope/vim-surround](https://github.com/tpope/vim-surround) - provides mappings to easily delete, change and add surroundings in pairs
    * [junegunn/vim-peekaboo](https://github.com/junegunn/vim-peekaboo) - extends `"` and `@` in normal mode and `<CTRL-R>` in insert mode so you can see the contents of the registers
    * [mbbill/undotree](https://github.com/mbbill/undotree) - visualizes undo history, `:UndotreeToggle`, `,tU`
    * Git inside Vim
        * [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) - `:Git`
        * [tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb) - `:GBrowse` to open GitHub URLs
        * [junegunn/gv.vim](https://github.com/junegunn/gv.vim) - a git commit browser, `:GV`
    * Gist inside Vim
        * [mattn/webapi-vim](https://github.com/mattn/webapi-vim)
        * [mattn/gist-vim](https://github.com/mattn/gist-vim) - `:Gist`, `:Gist -l dongminkim`
    * [mhinz/vim-signify](https://github.com/mhinz/vim-signify) - uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system (VCS)
    * [scrooloose/syntastic](https://github.com/scrooloose/syntastic) - a syntax checking plugin
    * [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree) - a file system explorer, `:NERDTreeToggle`, `,t.`
    * [majutsushi/tagbar](https://github.com/majutsushi/tagbar) - a class outline viewer, `:TagbarToggle`, `,tT`
    * [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) - a fzf integration plugin, `:Buffers`, `:GFiles`, `:Windows`, `:Rg [PATTERN]`
    * Completion
        * [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) - supports snippet and additional text editing, [(coc extensions)](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions)
        * [wellle/tmux-complete.vim](https://github.com/wellle/tmux-complete.vim) - a plugin for insert mode completion of words in adjacent tmux panes
    * Additional Language Supports
        * [sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot) - a collection of language packs
        * [plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown) - markdown
        * [mattn/emmet-vim](https://github.com/mattn/emmet-vim) - html template
    * [tpope/vim-characterize](https://github.com/tpope/vim-characterize) - reveals a character representation in decimal, octal, and hex, `ga` 🔍

### Customization

* Shell rc files with `.os.$(uname -s)` prefix will be loaded
    * `.os.$(uname -s)._shrc`(for both zsh and bash), `.os.$(uname -s).zshrc`, `.os.$(uname -s).bashrc`
        * e.g. `.os.Darwin.zshrc` will be loaded in Mac OS X zsh
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

## Usage

### tmux

`tmux` key bindings are heavily modified to be similar with `GNU screen` and `vim`.

First of all, prefix changed from `C-b` to `C-a`.

Here are all the modified key bindings:

| key bindings | action |
| ------------ | ------ |
| `a` | `send-prefix` |
| `C-r` | reload conf |
| `*` | `list-clients` |
| `C-l` | `refresh-client` |
| `d`, `C-d` | `detach` |
| `M-s` | `rename-session` |
| `M-q` | `kill-session` |
| `c`, `C-c` | `new-window` |
| `A` | `rename-window` |
| `C-a` | `last-window` |
| `C-n` | `next-window` |
| `p`, `C-p`, `BSpace` | `previous-window` |
| `w`, `C-w`, `"`, `Space` | `choose-window` |
| `C-k` | `kill-window` |
| `S` | `split-window` horizontally |
| `V` | `split-window` vertically |
| `T` | `break-pane` into new window |
| `_`, `Enter` | `resize-pane` to zoom in & out |
| `Tab`, `BTab` | `select-pane` next, previous |
| `h`, `j`, `k`, `l` | `select-pane` left, down, up, right |
| `M-h`, `M-j`, `M-k`, `M-l` | `resize-pane` left, down, up, right |
| `L` | `next-layout` |
| `C-x` | `kill-pane` |
| `R` | `respawn-pane` |
| *(copy mode)* `Space`, `v` | `begin-selection` |
| *(copy mode)* `Enter`, `y` | `copy-selection` |

And I made `tmx` shell function that does run the user-defined startup script, attach to existing session or duplicate and open duplicated session.

```sh
tmx foo
```
* if there is a tmux session with name `foo`,
    * attach to the existing `foo` session
* if there is no tmux session with name `foo`,
    * if there is a runnable function or command `tmx-foo`,
        * run `tmx-foo foo` that might make a tmux session with name `foo`
    * if there is no function or command `tmx-foo`,
        * just open a new tmux session with name `foo`

```sh
tmx -d foo
```
* if there is a tmux session with name `foo`,
    * duplicate the existing `foo` session and name it `foo~1` and attach to it
* if there is no tmux session with name `foo`,
    * just print error message

Here is a sample tmx startup script `tmx-foo`

```sh
function tmx-foo {
# http://superuser.com/questions/200382/how-do-i-get-tmux-to-open-up-a-set-of-panes-without-manually-entering-them/200453#200453
    local ses_name="${1-foo}"
    # Here I don't use pushd & popd because of oh-my-zsh's 'setopt auto_pushd'
    local _pwd="$PWD"
    cd "$HOME"
    tmux new-session -d -s $ses_name
    tmux rename-window -t $ses_name:0 '~'

    tmux set set-remain-on-exit on

        # All panes in 'foo-main' window are not destroyed on exit
        # You can type `C-a` `R` to respawn exited pane
        cd "$HOME/work/foo"
        tmux new-window -t $ses_name:1 -n 'foo-main'
        tmux splitw -t 0 dev_appserver.py --host 0.0.0.0 app.yaml

    tmux set -u set-remain-on-exit

    tmux select-window -t $ses_name:0
    tmux select-pane -t 0
    cd "$_pwd"
    tmux attach-session -t $ses_name
}
```

## License

[MIT](LICENSE)

## Author

[@dongminkim](https://github.com/dongminkim)

*aka `vanity` or `diego`*

