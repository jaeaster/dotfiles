let mapleader = ","
" Install VimPlug for Vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/vim/plugged')

" colorschemes
Plug 'joshdick/onedark.vim'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" utilities
Plug 'scrooloose/nerdtree' " Filesystem explorer
Plug '/usr/local/opt/fzf' " Fuzzy file finder
Plug 'junegunn/fzf.vim'
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
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'

call plug#end()

set rtp+=/usr/local/opt/fzf

" Disable Arrow Keys
nnoremap <Left> :echo "No Left for you!"<CR>
vnoremap <Left> :<C-u>echo "No Left for you!"<CR>
inoremap <Left> <C-o>:echo "No Left for you!"<CR>

nnoremap <Right> :echo "No Right for you!"<CR>
vnoremap <Right> :<C-u>echo "No Right for you!"<CR>
inoremap <Right> <C-o>:echo "No Right for you!"<CR>

nnoremap <Up> :echo "No Up for you!"<CR>
vnoremap <Up> :<C-u>echo "No Up for you!"<CR>
inoremap <Up> <C-o>:echo "No Up for you!"<CR>

nnoremap <Down> :echo "No Down for you!"<CR>
vnoremap <Down> :<C-u>echo "No Down for you!"<CR>
inoremap <Down> <C-o>:echo "No Down for you!"<CR>

" Colorscheme related

if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_termcolors=16

syntax on
colorscheme onedark
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set nocompatible
set autoread

set history=1000
set textwidth=120

set number

set formatoptions-=tc
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

filetype plugin indent on
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype c,cpp setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

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

