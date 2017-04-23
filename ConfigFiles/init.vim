set number
set title
set showmatch
set tabstop=4
set softtabstop=4
set smartindent

set shiftwidth=4
set autoindent
set expandtab

set ignorecase
set smartcase
set wrapscan

set hlsearch

set ruler
set noswapfile
set wildmenu wildmode=list:full

nnoremap :tree :NERDTreeToggle

"auto comment off"
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END


"dein Scripts-----------------------------
let s:dein_cache_dir = $XDG_CACHE_HOME . '/dein'
let s:dein_dir = $XDG_CACHE_HOME . '/dein/repos/github.com/Shougo/dein.vim'
let s:dein_config_dir = $XDG_CONFIG_HOME . '/nvim'

if &compatible
  set nocompatible               " Be iMproved
endif

if &runtimepath !~# '/dein.vim'
    execute 'set runtimepath^=' . s:dein_dir
endif

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml = s:dein_config_dir . '/dein.toml'
  let s:toml_lazy = s:dein_config_dir . '/dein_lazy.toml'
  
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})
  
  call dein#end()
  call dein#save_state()
endif

" hook_sourceに設定している内容を展開する
call dein#call_hook('source')

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
