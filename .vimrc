" .vimrc

" vimconf is not vi-compatible {{{
    set nocompatible
" }}}

" Vundle plugin manager {{{
    " Automatically setting up Vundle {{{
    " http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
            let has_vundle=0
        endif
    " }}}

    " Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    " }}}

    " Github repos, uncomment to disable a plugin {{{
        Plugin 'gmarik/Vundle.vim'

        " Local plugins (and only plugins in this file!) {{{
            if filereadable($HOME."/.local.plugins.vimrc")
                source $HOME/.local.plugins.vimrc
            endif
        " }}}

        " <Tab> everything!
        Plugin 'ervandew/supertab'

        " Fuzzy finder (files, mru, etc)
        Plugin 'ctrlpvim/ctrlp.vim'

        " Powerline
        Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

        " Bufferline
        Plugin 'bling/vim-bufferline'

        " Glorious colorscheme
        Plugin 'nanotech/jellybeans.vim'
        Plugin 'altercation/vim-colors-solarized'

        " Super easy commenting, toggle comments etc
        Plugin 'scrooloose/nerdcommenter'

        " Autoclose (, " etc
        Plugin 'somini/vim-autoclose'

        " Git wrapper inside Vim
        Plugin 'tpope/vim-fugitive'

        " Handle surround chars like ''
        Plugin 'tpope/vim-surround'

        " Align your = etc.
        Plugin 'vim-scripts/Align'

        " Snippets like textmate
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        Plugin 'honza/vim-snippets'
        Plugin 'garbas/vim-snipmate'

        " A fancy start screen, shows MRU etc.
        Plugin 'mhinz/vim-startify'

        " Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
        Plugin 'mhinz/vim-signify'

        " Awesome syntax checker.
        " REQUIREMENTS: See :h syntastic-intro
        Plugin 'scrooloose/syntastic'

        " Functions, class data etc.
        " REQUIREMENTS: (exuberant)-ctags
        Plugin 'majutsushi/tagbar'
    " }}}

    " Finish Vundle stuff {{{
        call vundle#end()
    " }}}

    " Installing plugins the first time, quits when done {{{
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    " }}}
" }}}

" Local leading config, only for prerequisites and will be overwritten {{{
    if filereadable($HOME."/.local.pre.vimrc")
        source $HOME/.local.pre.vimrc
    endif
" }}}

" User interface {{{
    " Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        if !empty($VIM_THEME)
            let _ = split($VIM_THEME, ':')          " VIM_THEME=light:solarized vim
            execute "set background="._[0]
            execute "colorscheme "._[1]
        else
            set background=dark                     " we're using a dark bg
            colorscheme jellybeans                  " colorscheme from plugin
        endif

        " Force behavior and filetypes, and by extension highlighting {{{
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        " }}}

        " 256 colors for maximum jellybeans bling. See commit log for info {{{
            if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            endif
        " }}}
    " }}}

    " Interface general {{{
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        " Depending on your setup you may want to enforce UTF-8. {{{
            " Should generally be set in your environment LOCALE/$LANG
            "set encoding=utf-8                    " default $LANG/latin1
            "set fileencoding=utf-8                " default none
            set fileencodings=ucs-bom,utf-8,cp949,euc-kr,latin1
            if v:ctype =~? '\<UTF-*8$' || v:ctype ==? "C" && v:lang =~? '\<UTF-*8$'
                set termencoding=utf-8
            endif
        " }}}
        " Gvim {{{
            set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        " }}}
    " }}}
" }}}

" General settings {{{
    set completeopt=menu,preview,longest            " insert mode completion
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <tab>
    set list                                        " displaying listchars
    set mouse=a                                     " enable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set nosplitbelow                                " splits go above w/focus
    set nosplitright                                " vsplits go left w/focus
    set ttyfast                                     " for faster redraws etc
    set ttymouse=xterm2                             " experimental
    set clipboard=unnamed                           " use osx pasteboard
    " Folding {{{
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    " }}}
    " Search and replace {{{
        set nogdefault                              " default :s//g unset
        set incsearch                               " "live"-search
        set hlsearch                                " highlighted search
    " }}}
    " Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    " }}}
    " Wildmode/wildmenu command-line completion {{{
        set wildignore+=*.bak,*.swp,*.swo
        set wildignore+=*.a,*.o,*.so,*.pyc,*.class
        set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.pdf
        set wildignore+=*/.git*,*.tar,*.zip
        set wildmenu
        set wildmode=longest:full,list:full
    " }}}
    " Return to last edit position when opening files {{{
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     execute "normal! g`\"" |
                \ endif
        augroup END
    " }}}
" }}}

" Keybindings {{{
    " General {{{
        " Remap <leader>
        let mapleader=","

        " Quickly edit/source .vimrc
        noremap <leader>ve :edit $HOME/.vimrc<CR>
        noremap <leader>vs :source $HOME/.vimrc<CR>

        " Yank(copy) to system clipboard
        noremap <leader>y "+y

        " Toggle pastemode, doesn't indent
        set pastetoggle=<leader>tp

        " Toggle folding
        " http://vim.wikia.com/wiki/Folding#Mappings_to_toggle_folds
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Scroll up/down lines from 'scroll' option, default half a screen
        map <C-j> <C-d>
        map <C-k> <C-u>

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " We don't need any help!
        inoremap <F1> <nop>
        nnoremap <F1> <nop>
        vnoremap <F1> <nop>

        " Disable annoying ex mode (Q)
        map Q <nop>

        " Buffers, preferred over tabs now with bufferline.
        nnoremap gn :bnext<CR>
        nnoremap gN :bprevious<CR>
        nnoremap gd :bdelete<CR>
        nnoremap gf <C-^>

        " Highlight last inserted text
        nnoremap gV '[V']
    " }}}

    " Functions and/or fancy keybinds {{{
        " Toggle syntax highlighting {{{
            function! ToggleSyntaxHighlighthing()
                if exists("g:syntax_on")
                    syntax off
                else
                    syntax on
                endif
            endfunction
            nnoremap <leader>ts :call ToggleSyntaxHighlighthing()<CR>
        " }}}

        " Toggle highlighted search {{{
            function! ToggleHighlightedSearch()
                if (&hlsearch == 1)
                    setlocal nohlsearch
                else
                    setlocal hlsearch
                endif
                setlocal hlsearch?
            endfunction
            nnoremap th :call ToggleHighlightedSearch()<CR>
        " }}}

        " Clear last used search pattern
        nnoremap <silent><CR> :let @/ = ""<CR>

        " Highlight characters past 79 {{{
        " You might want to override this function and its variables with
        " your own in .local.vimrc which might set for example colorcolumn or
        " even the textwidth. See https://github.com/timss/vimconf/pull/4
            let g:overlength_enabled = 0
            highlight OverLength ctermbg=238 guibg=#444444

            function! ToggleOverLengthHighlight()
                if g:overlength_enabled == 0
                    match OverLength /\%79v.*/
                    let g:overlength_enabled = 1
                    echo 'OverLength highlighting turned on'
                else
                    match
                    let g:overlength_enabled = 0
                    echo 'OverLength highlighting turned off'
                endif
            endfunction
            nnoremap <leader>tlh :call ToggleOverLengthHighlight()<CR>
        " }}}

        " Toggle number {{{
            function! NumberToggle()
                if (&number == 1)
                    setlocal nonumber
                else
                    setlocal number
                endif
                setlocal number?
            endfunction
            nnoremap <leader>tn :call NumberToggle()<CR>
        " }}}

        " Toggle relativenumber {{{
            function! RelativeNumberToggle()
                if (&relativenumber == 1)
                    setlocal norelativenumber
                else
                    setlocal relativenumber
                endif
                setlocal relativenumber?
            endfunction
            nnoremap <leader>trn :call RelativeNumberToggle()<CR>
        " }}}

        " Toggle text wrapping, wrap on whole words {{{
        " For more info see: http://stackoverflow.com/a/2470885/1076493
            function! WrapToggle()
                if &wrap
                    set list
                    set nowrap
                else
                    set nolist
                    set wrap
                endif
            endfunction
            nnoremap <leader>tw :call WrapToggle()<CR>
        " }}}

        " Remove multiple empty lines {{{
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction
            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>
        " }}}

        " Split to relative header/source {{{
            function! SplitRelSrc()
                let s:fname = expand("%:t:r")
                if expand("%:e") == "h"
                    set splitright
                    execute "vsplit" fnameescape(s:fname . ".cpp")
                    set nosplitright
                elseif expand("%:e") == "cpp"
                    execute "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction
            nnoremap <leader>sr :call SplitRelSrc()<CR>
        " }}}

        " Strip trailing whitespace, return to cursor at save {{{
            function! StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
                    \ autocmd BufWritePre <buffer> :call
                    \ StripTrailingWhitespace()
            augroup END
        " }}}

        " Write with Sudo {{{
            function! WriteWithSudo(fn)
                let choice = confirm("Write '".a:fn."' with sudo?", "&Yes\n&No", 2)
                if choice == 1
                    execute ":silent w !sudo tee '".a:fn."' > /dev/null"
                endif
            endfunction
            command! W :call WriteWithSudo(@%)<bar>:edit!
        " }}}
    " }}}

    " Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        map <leader>tT :TagbarToggle<CR>

        " Syntastic - toggle error list. Probably should be toggleable.
        noremap <silent><leader>tE :Errors<CR>
        noremap <silent><leader>tC :lclose<CR>
    " }}}
" }}}

" Files {{{
    set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups

    " Change into working directory {{{
    " Useful with noautochdir
        function! Cwd()
            cd %:h
            pwd
        endfunction
        nnoremap <leader>cwd :call Cwd()<CR>
    " }}}

    " Split window and edit directory {{{
        function! SplitAndEditDirectory(bVertical)
            if a:bVertical
                execute "vertical split"
            else
                execute "split"
            endif

            let dir = expand("%:h")
            if strlen(dir) == 0
                let dir = "."
            endif
            execute "edit ".dir
        endfunction
        nnoremap <leader>sD :call SplitAndEditDirectory(0)<CR>
        nnoremap <leader>vsD :call SplitAndEditDirectory(1)<CR>
    " }}}

    " Clear undo. Requires Vim 7.3 {{{
        function! ClearUndo()
            let choice = confirm("Clear undo history?", "&Yes\n&No", 2)
            if choice == 1
                " :help clear-undo (Vim 7.3+)
                let old_undolevels = &undolevels
                set undolevels=-1
                execute "normal a \<Bs>\<Esc>"
                let &undolevels = old_undolevels
                echo "done."
            endif
        endfunction
        nnoremap <leader>dU :call ClearUndo()<CR>
    " }}}

    " Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    " }}}

    " Swap files, unless vim is invoked using sudo {{{
    " https://github.com/tejr/dotfiles/blob/master/vim/vimrc
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            " Don't swap tmp, mount or network dirs {{{
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                        \ setlocal noswapfile
                augroup END
            " }}}
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    " }}}

    " Automatically create needed files and folders on first run (*nix only) {{{
        if !has("win32") && !has("win16")
            call system("mkdir -p $HOME/.vim/{swap,undo}")
            "if !filereadable($HOME."/.local.pre.vimrc") | call system("touch $HOME/.local.pre.vimrc") | endif
            "if !filereadable($HOME."/.local.plugins.vimrc") | call system("touch $HOME/.local.plugins.vimrc") | endif
            "if !filereadable($HOME."/.local.vimrc") | call system("touch $HOME/.local.vimrc") | endif
        endif
    " }}}
" }}}

" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
    " Only auto-comment newline for block comments {{{
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    " }}}
    " Take comment leaders into account when joining lines, :h fo-table {{{
    " http://ftp.vim.org/pub/vim/patches/7.3/7.3.541
        if has("patch-7.3.541")
            set formatoptions+=j
        endif
    " }}}
" }}}

" Plugin settings {{{
    " Startify {{{
        let g:startify_bookmarks = [
            \ $HOME . "/.vimrc",
            \ $HOME . "/.local.pre.vimrc",
            \ $HOME . "/.local.plugins.vimrc",
            \ $HOME . "/.local.vimrc"
            \ ]
        let g:startify_custom_header = [
            \ '   http://github.com/dongminkim/dotfiles',
            \ '   ← http://github.com/timss/vimconf',
            \ ''
            \ ]
        let g:startify_files_number = 5
    " }}}
    " CtrlP {{{
        " Don't recalculate files on start (slow)
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_working_path_mode = 'ra'

        " Don't split in Startify
        let g:ctrlp_reuse_window = 'startify'
    " }}}
    " TagBar {{{
        set tags=tags;/

        " Proportions
        let g:tagbar_left = 0
        let g:tagbar_width = 30
    " }}}
    " Syntastic {{{
        " Automatic checking for active, only when :SyntasticCheck for passive
        " NOTE: override these in $HOME/.local.vimrc as needed!
        let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes':
                \ ['c', 'cpp', 'perl', 'python'] }

        " Skip check on :wq, :x, :ZZ etc
        let g:syntastic_check_on_wq = 0
    " }}}
    " Netrw {{{
        let g:netrw_banner = 0
        let g:netrw_list_hide = '^\.$'
        let g:netrw_liststyle = 3
    " }}}
    " Supertab {{{
        " Complete based on context (compl-omni, compl-filename, ..)
        let g:SuperTabDefaultCompletionType = "context"

        " Longest common match, e.g. 'b<tab>' => 'bar' for 'barbar', 'barfoo'
        let g:SuperTabLongestEnhanced = 1
        let g:SuperTabLongestHighlight = 1
    " }}}
    " SnipMate {{{
        " Disable '.' => 'self' Python snippet
        " Breaks SuperTab with omnicomplete (e.g. module.<Tab>)
        function! DisablePythonSelfSnippet()
            let l:pysnip = $HOME."/.vim/after/snippets/python.snippets"
            if !filereadable(l:pysnip)
                call system("echo 'snippet!! .' > " . l:pysnip)
            endif
        endfunction

        augroup DisablePythonSelfSnippet
            autocmd!
            autocmd BufNewFile,BufRead *.py :call DisablePythonSelfSnippet()
        augroup END
    " }}}
    " Automatically remove preview window after autocomplete {{{
    " (mainly for clang_complete)
        augroup RemovePreview
            autocmd!
            autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif
            autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
        augroup END
    " }}}
" }}}

" Local ending config, will overwrite anything above. Generally use this. {{{
    if filereadable($HOME."/.local.vimrc")
        source $HOME/.local.vimrc
    endif
" }}}

