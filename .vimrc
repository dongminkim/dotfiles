" .vimrc
" vim:foldmethod=marker

" vimconf is not vi-compatible {{{
    set nocompatible
" }}}

" Plugin manager {{{
    " Automatically setting up vim-plug {{{
        if empty(glob('~/.vim/autoload/plug.vim'))
            let has_vim_plug = 0
            echo 'install vim-plug ...'
            echo ''
            silent !mkdir -p ~/.vim/plugged
            silent !mkdir -p ~/.vim/autoload
            silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
        else
            let has_vim_plug = 1
        endif
    " }}}

    call plug#begin('~/.vim/plugged')

    " Load Plugins {{{
        " colorschemes
        Plug 'nanotech/jellybeans.vim'
        Plug 'altercation/vim-colors-solarized'

        " status line
        Plug 'vim-airline/vim-airline' | Plug 'edkolev/tmuxline.vim'

        " a fancy start screen
        Plug 'mhinz/vim-startify'

        " pairs of handy bracket mappings,
        " https://noahfrederick.com/log/a-list-of-vims-lists
        Plug 'tpope/vim-unimpaired'

        " provides mappings to easily delete, change and add surroundings in pairs
        Plug 'tpope/vim-surround'

        " extends `"` and `@` in normal mode and `<CTRL-R>` in insert mode so you can see the contents of the registers
        Plug 'junegunn/vim-peekaboo'

        " visualizes undo history, `:UndotreeToggle`, `,tU`
        Plug 'mbbill/undotree'

        " Git inside Vim
        Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb' | Plug 'junegunn/gv.vim'

        " Git blamer just like VS Code's GitLens
        "Plug 'APZelos/blamer.nvim'

        " Gist inside Vim
        Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

        " uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system (VCS)
        Plug 'mhinz/vim-signify'

        " a syntax checking plugin
        Plug 'scrooloose/syntastic'

        " NERDTree
        Plug 'scrooloose/nerdtree'

        " Class outline viewer
        Plug 'majutsushi/tagbar'

        " FZF - Fuzzy Finder
        Plug 'junegunn/fzf.vim'
        " M1 macOS runtimepath is /opt/homebrew/opt/fzf
        Plug (has('mac') && system('uname -m') =~ 'arm64' ? '/opt/homebrew/opt/fzf' : '/usr/local/opt/fzf')

        " supports snippet and additional text editing
        " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
        Plug 'neoclide/coc.nvim', {'branch': 'release'}

        " a plugin for insert mode completion of words in adjacent tmux panes
        Plug 'wellle/tmux-complete.vim'

        " a collection of language packs
        Plug 'sheerun/vim-polyglot'

        " markdown
        Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

        " html template
        Plug 'mattn/emmet-vim', { 'for': 'html' }

        " reveals a Unicode character representation in decimal, octal, and hex, `ga` 🔍
        Plug 'tpope/vim-characterize'
        "Plug 'chrisbra/unicode.vim'

        " Markdown preview on OS X
        "Plug 'junegunn/vim-xmark', { 'for': 'markdown', 'do': 'make' }

        " Smooth scrolling for Vim done right
        "Plug 'psliwka/vim-smoothie'

        " searches and loads all `.lvimrc` files up to the root directory
        "Plug 'embear/vim-localvimrc'
    " }}}

   " Load local plugins {{{
        if filereadable($HOME.'/.local.plugins.vimrc')
            source $HOME/.local.plugins.vimrc
        endif
    " }}}

    call plug#end()

    " Install plugins for the first time, and quits when done {{{
        if has_vim_plug == 0
            silent! PlugInstall
            qa
        endif
    " }}}
" }}}

" Local leading config, only for prerequisites and will be overwritten {{{
    if filereadable($HOME.'/.local.pre.vimrc')
        source $HOME/.local.pre.vimrc
    endif
" }}}

" User interface {{{
    " Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        if !empty($VIM_THEME)
            let _ = split($VIM_THEME, ':')          " VIM_THEME=light:solarized vim
            execute 'set background='._[0]
            execute 'colorscheme '._[1]
        else
            set background=dark                     " we're using a dark bg
            colorscheme jellybeans                  " colorscheme from plugin
        endif

        " Force behavior and filetypes, and by extension highlighting {{{
            augroup FileTypeRules
                autocmd!
                "autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                "autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        " }}}

        " 256 colors for maximum jellybeans bling. See commit log for info {{{
            if (&term =~ 'xterm') || (&term =~ 'screen')
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
            if v:ctype =~? '\<UTF-*8$' || v:ctype ==? 'C' && v:lang =~? '\<UTF-*8$'
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
    set iskeyword+=_                                " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <Tab>
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
        if executable('rg')
            set grepprg=rg\ --vimgrep               " use rg over grep
        elseif executable('ag')
            set grepprg=ag\ --nogroup\ --nocolor    " use ag over grep
        endif
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

" Key bindings {{{
    " General {{{
        " Remap <Leader>
        let mapleader=','

        " Quickly edit/source .vimrc
        nnoremap <Leader><C-o> :new $HOME/.vimrc<CR>
        nnoremap <Leader><C-r> :source $HOME/.vimrc<CR>

        " Yank(copy) to system clipboard
        noremap <Leader>y "+y

        " Toggle pastemode, doesn't indent
        set pastetoggle=<Leader>tp

        " Toggle folding
        " http://vim.wikia.com/wiki/Folding#Mappings_to_toggle_folds
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

        " Scroll up/down lines from 'scroll' option, default half a screen
        map <C-j> <C-d>
        map <C-k> <C-u>

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " We don't need any help!
        inoremap <F1> <Nop>
        nnoremap <F1> <Nop>
        vnoremap <F1> <Nop>

        " Disable annoying ex mode (Q)
        map Q <Nop>

        " Buffers, preferred over tabs now with bufferline.
        nnoremap gn :bnext<CR>
        nnoremap gp :bprevious<CR>
        nnoremap gd :bdelete<CR>

        " Highlight last inserted text
        nnoremap gV '[V']
    " }}}

    " Functions and/or fancy keybinds {{{
        " Toggle syntax highlighting {{{
            function! ToggleSyntaxHighlighthing()
                if exists('g:syntax_on')
                    syntax off
                else
                    syntax on
                endif
            endfunction
            nnoremap <Leader>ts :call ToggleSyntaxHighlighthing()<CR>
        " }}}

        " Toggle highlighted search {{{
            function! ToggleHighlightedSearch()
                setlocal hlsearch!
                setlocal hlsearch?
            endfunction
            nnoremap th :call ToggleHighlightedSearch()<CR>
        " }}}

        " Clear last used search pattern
        nnoremap <silent><CR> :let @/ = ''<CR>

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
            nnoremap <Leader>tlh :call ToggleOverLengthHighlight()<CR>
        " }}}

        " Toggle number {{{
            function! ToggleNumber()
                setlocal number!
                setlocal number?
            endfunction
            nnoremap <Leader>tn :call ToggleNumber()<CR>
        " }}}

        " Toggle relativenumber {{{
            function! ToggleRelativeNumber()
                setlocal relativenumber!
                setlocal relativenumber?
            endfunction
            nnoremap <Leader>trn :call ToggleRelativeNumber()<CR>
        " }}}

        " Toggle text wrapping, wrap on whole words {{{
        " For more info see: http://stackoverflow.com/a/2470885/1076493
            function! ToggleWrap()
                set wrap!
                set wrap?
            endfunction
            nnoremap <Leader>tw :call ToggleWrap()<CR>
        " }}}

        " Remove multiple empty lines {{{
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction
            nnoremap <Leader>ld :call DeleteMultipleEmptyLines()<CR>
        " }}}

        " Split to relative header/source {{{
            function! SplitRelSrc()
                let s:fname = expand('%:t:r')
                if expand('%:e') == 'h'
                    set splitright
                    execute 'vsplit' fnameescape(s:fname . '.cpp')
                    set nosplitright
                elseif expand("%:e") == "cpp"
                    execute 'vsplit' fnameescape(s:fname . '.h')
                endif
            endfunction
            nnoremap <Leader>sr :call SplitRelSrc()<CR>
        " }}}

        " Strip trailing whitespace, return to cursor at save {{{
            function! StripTrailingWhitespace()
                let l = line('.')
                let c = col('.')
                %s/\s\+$//e
                call cursor(l, c)
            endfunction
            nnoremap <Leader><Space>d :call StripTrailingWhitespace()<CR>

            augroup StripTrailingWhitespace
                autocmd!
                "autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
                "    \ autocmd BufWritePre <Buffer> :call
                "    \ StripTrailingWhitespace()
            augroup END
        " }}}

        " Write and Sudo {{{
            function! WriteWithSudo(fn)
                let choice = confirm("Write '".a:fn."' with sudo?", "&Yes\n&No", 2)
                if choice == 1
                    execute ":silent w !sudo tee '".a:fn."' > /dev/null"
                endif
            endfunction
            command! SudoWrite :call WriteWithSudo(@%)<Bar>:edit!
            command! W :write
        " }}}
    " }}}
" }}}

" Files {{{
    set noautochdir                                 " disable auto chdir
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups

    " Toggle autochdir {{{
        function! ToggleAutochdir()
            setlocal autochdir!
            setlocal autochdir?
        endfunction
        nnoremap <Leader>tcd :call ToggleAutochdir()<CR>
    " }}}

    " Change into working directory {{{
    " Useful with noautochdir
        function! Cwd()
            cd %:h
            pwd
        endfunction
        nnoremap <Leader>cwd :call Cwd()<CR>
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
        nnoremap <Leader>S :call SplitAndEditDirectory(0)<CR>
        nnoremap <Leader>V :call SplitAndEditDirectory(1)<CR>
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
        nnoremap <Leader>dU :call ClearUndo()<CR>
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
            "if !filereadable($HOME."/.local.plugins.vimrc") | call system("touch $HOME/.local.plugins.vimrc") | endif
            "if !filereadable($HOME."/.local.pre.vimrc") | call system("touch $HOME/.local.pre.vimrc") | endif
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
    set softtabstop=4                               " "tab" feels like <Tab>
    set tabstop=4                                   " replace <Tab> w/4 spaces
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
    " vim-airline {{{
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
    " }}}
    " Startify {{{
        let g:startify_bookmarks = [
            \ $HOME . "/.vimrc",
            \ $HOME . "/.local.plugins.vimrc",
            \ $HOME . "/.local.pre.vimrc",
            \ $HOME . "/.local.vimrc"
            \ ]
        let g:startify_custom_header = [
            \ '   http://github.com/dongminkim/dotfiles',
            \ ''
            \ ]
        let g:startify_files_number = 5
    " }}}
    " Tagbar {{{
        set tags=tags;/

        " Proportions
        let g:tagbar_left = 0
        let g:tagbar_width = 30

        " Toggle tagbar (definitions, functions etc.)
        map <Leader>tT :TagbarToggle<CR>
    " }}}
    " FZF {{{
        " This is the default extra key bindings
        let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit' }

        " Mapping selecting mappings
        nmap <Leader><Tab> <Plug>(fzf-maps-n)
        xmap <Leader><Tab> <Plug>(fzf-maps-x)
        omap <Leader><Tab> <Plug>(fzf-maps-o)

        " Insert mode completion
        imap <C-f><C-d> <Plug>(fzf-complete-word)
        imap <C-f><C-f> <Plug>(fzf-complete-path)
        imap <C-f><C-g> <Plug>(fzf-complete-file-ag)
        imap <C-f><C-l> <Plug>(fzf-complete-line)

        " Set base dir for :Files {{{
            let g:fzf_base_dir = getcwd()
            function! SetFzfBaseDir()
                let path = input('FZF Base Dir ['.getcwd().']: ', '', 'dir')
                if path !~ '^\s*$' 
                    execute 'cd '.path
                endif
                let g:fzf_base_dir = getcwd()
                cd -
                redraw
                echo g:fzf_base_dir
            endfunction
            nnoremap <Leader>fcd :call SetFzfBaseDir()<CR>
        " }}}

        " Key bindings
        nmap <C-w><Space> :Windows<CR>
    " }}}
    " Coc {{{
        " You can also install coc-extensions with :CocInstall
        let g:coc_global_extensions = ['coc-tabnine', 'coc-json']
        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
        if exists('*complete_info')
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
            inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif
    " }}}
    " Fugitive {{{
        autocmd User fugitive 
            \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
            \   nnoremap <buffer> .. :edit %:h<CR> |
            \ endif
        " :Gdiffsplit!
        nnoremap <leader>dgh :diffget //2<CR>
        nnoremap <leader>dgl :diffget //3<CR>
    " }}}
    " Blamer {{{
        let g:blamer_enabled = 1
        let g:blamer_delay = 500
        let g:blamer_relative_time = 1
        let g:blamer_show_in_visual_modes = 1
        let g:blamer_show_in_insert_modes = 0
    " }}}
    " Syntastic {{{
        " Automatic checking for active, only when :SyntasticCheck for passive
        "let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['c', 'cpp', 'perl', 'python'] }

        " Skip check on :wq, :x, :ZZ etc
        let g:syntastic_check_on_wq = 0

        " Syntastic - toggle error list
        noremap <silent><Leader>tE :Errors<CR>
        noremap <silent><Leader>tC :lclose<CR>
    " }}}
    " Signify {{{
        " Enable signify only with git
        "let g:signify_vcs_list = [ 'git' ]
    " }}}
    " NERDTree {{{
        " NERDTree toggle
        noremap <silent><Leader>t. :NERDTreeToggle<CR>
    " }}}
    " Netrw {{{
        let g:netrw_banner = 0
        let g:netrw_list_hide = '^\.$'
        let g:netrw_liststyle = 3
    " }}}
    " Undo-tree {{{
        nnoremap <Leader>tU :UndotreeToggle<CR>
        nnoremap <Leader>dU :call ClearUndo()<CR><Bar>:UndotreeHide<CR>
    " }}}
    " Gist-vim {{{
        let g:gist_detect_filetype = 1
        let g:gist_post_private = 1
        let g:gist_show_privates = 1
        let g:gist_get_multiplefile = 1
    " }}}
    " Emmet {{{
        "let g:user_emmet_leader_key='<C-y>'
    " }}}
    " Localvimrc {{{
         let g:localvimrc_whitelist = $HOME.'/.*'
    " }}}
" }}}

" Local ending config, will overwrite anything above. Generally use this. {{{
    if filereadable($HOME."/.local.vimrc")
        source $HOME/.local.vimrc
    endif
" }}}
