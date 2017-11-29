let mapleader = ","
call plug#begin('~/.config/vim/plugged')

" colorschemes
Plug 'joshdick/onedark.vim'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" utilities
Plug 'scrooloose/nerdtree' " Filesystem explorer
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy file finder and so much more
Plug 'mileszs/ack.vim' " search inside files using ack. Same as command line ack utility, but use :Ack
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'tpope/vim-commentary' " toggle comments
Plug 'tpope/vim-endwise' " automatically add end in ruby
Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'tpope/vim-fugitive' " amazing git wrapper for vim
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'MarcWeber/vim-addon-mw-utils' " interpret a file by function and cache file automatically
Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
Plug 'itchyny/lightline.vim' " Status bar

call plug#end()
set rtp+=/usr/local/opt/fzf

" Colorscheme related

if (has("nvim"))
 let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_termcolors=16

colorscheme onedark
syntax on
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set nocompatible
set autoread

set history=1000
set textwidth=120

set number

set wrap
set wrapmargin=8
set linebreak
set showbreak=...

set autoindent
set smartindent

set backspace=indent,eol,start

set clipboard=unnamed

set wildmenu
set showcmd
set wildmode=list:longest
set shell=$SHELL
set title

set ignorecase
set smartcase
set hlsearch
set incsearch

set magic

set showmatch
set mat=2

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype c setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" SPLITS
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" KEY MAPPINGS
nmap ; :Buffers<CR>
nmap <leader>v :vsp<CR>
nmap <leader>s :sp<CR>

