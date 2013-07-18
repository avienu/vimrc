" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Call Pathogen for plugin management
call pathogen#runtime_append_all_bundles()

set clipboard=unnamed

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set directory=/Users/soconnor/vimfiles
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wildmenu		" Tab complention in the menu area
set ts=4 sts=4 sw=4 expandtab
set nu              " I like line numbers
colorscheme inkpot
"colorscheme xoria256
"colorscheme desert

" Set gundo to F4
nmap <F4> :GundoToggle<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Shortcut to NERDTree
nmap <leader>nt :NERDTree<CR>

" Shortcut to turn on spelling
nmap <leader>s :set spell!<CR>

" Shortcut for toggling the taglist
nmap <leader>tl :TlistToggle<CR>

" Shortcut for toggling line numbers
nmap <leader>tn :set nu!<CR>

" Map leader w to control w. Control key is too hard to hit without taking
" fingers off home row.
nmap <leader>w <C-W>

" Set the default to American english
set spelllang=en_us

"  
"  " Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
"  colorscheme xoria256
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When working with Restructured Text files use spell check
  autocmd FileType rst setlocal spell spelllang=en_us
  autocmd FileType rst setlocal colorcolumn=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  autocmd BufWritePost .vimrc :source ~/.vimrc

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
