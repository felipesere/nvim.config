" Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'

  Plug 'editorconfig/editorconfig-vim'
  Plug 'Shougo/deoplete.nvim'

  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'

  Plug 'ervandew/supertab'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'bkad/vim-terraform',      { 'for' :  'terraform' }
  Plug 'elixir-lang/vim-elixir',  { 'for' : ['elixir', 'eelixir'] }
  Plug 'slashmili/alchemist.vim', { 'for' : ['elixir', 'eelixir'] }
  Plug 'tfnico/vim-gradle',       { 'for' : 'groovy' }
  Plug 'cakebaker/scss-syntax.vim', { 'for' : 'scss' }
  Plug 'cespare/vim-toml', { 'for' : 'toml' }
  Plug 'wting/rust.vim',   { 'for' : 'rust' }
  Plug 'ElmCast/elm-vim',  { 'for' : 'elm' }
call plug#end()

scriptencoding utf-8
set encoding=utf-8

syntax on                         " show syntax highlighting
filetype plugin indent on
set backspace=indent,eol,start    " respect backspace
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set number                        " show the absolute number as well
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line (DISABLED)
set nocursorcolumn
set nofoldenable                  " disable code folding
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set mouse=                        " enable mouse support
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set scrolloff=5                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods
set shortmess+=I
set noswapfile

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner=0
let g:deoplete#enable_at_startup = 1

" set color scheme
colorscheme base16-default
set background=dark

let g:airline_theme = 'base16'

" set up some custom colors
highlight ColorColumn  ctermbg=00
highlight LineNr       ctermbg=00 ctermfg=240

set pastetoggle=<F2>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

command Q execute "qa!"

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''

let g:RootIgnoreUseHome = 1

let mapleader = ","
map <leader>S :so $MYVIMRC <cr>

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
map <c-p> :execute 'FZF'<CR>
map <silent> <leader><space> :nohl<cr>

"  eliminate white spaace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFind<CR>

" map . in visual mode
vnoremap . :norm.<cr>

function! s:tab_complete_forward()
  " is completion menu open? cycle to next item
  if pumvisible()
    return "\<c-n>"
  endif

  " is there a snippet that can be expanded?
  " is there a placholder inside the snippet that can be jumped to?
  if neosnippet#expandable_or_jumpable() 
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " if none of these match just use regular tab
  return "\<tab>"
endfunction

function! s:tab_complete_backward()
  " is completion menu open? cycle to next item
  if pumvisible()
    return "\<c-p>"
  endif

  " is there a snippet that can be expanded?
  " is there a placholder inside the snippet that can be jumped to?
  if neosnippet#expandable_or_jumpable() 
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " if none of these match just use regular tab
  return "\<tab>"
endfunction

imap <silent><expr><TAB> <SID>tab_complete_forward()
imap <silent><expr><S-TAB> <SID>tab_complete_backward()


" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>
