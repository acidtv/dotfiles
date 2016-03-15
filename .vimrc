set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Plugin 'altercation/vim-colors-solarized'
""Plugin 'kien/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-markdown'
Plugin 'mileszs/ack.vim'
Plugin 'bling/vim-airline'
"Plugin 'mhinz/vim-signify'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'vimwiki/vimwiki'
Plugin 'spiiph/vim-space'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Shougo/vimproc.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/argtextobj.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'thinca/vim-ref'
"Plugin 'junegunn/vim-pseudocl'
"Plugin 'junegunn/vim-oblique'
"Plugin 'easymotion/vim-easymotion'
"Plugin 'haya14busa/incsearch.vim'
"Plugin 'haya14busa/incsearch-fuzzy.vim'
"Plugin 'tpope/vim-sleuth'
Plugin 'chrisbra/csv.vim'
"Plugin 'nvie/vim-flake8'
" doesn't work with nvim :(
"Plugin 'sjl/gundo.vim'
"Plugin 'spf13/PIV'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'mbbill/undotree'

" vim-scripts repos
Plugin 'AutoClose'
Plugin 'taglist.vim'

" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!

" NOTE: comments after Bundle command are not allowed..

" ######### VIM settings ##################################

set encoding=utf-8
set gcr=a:blinkon0
set autoindent
set tabstop=4
set shiftwidth=4
set noexpandtab
set nowrap
set hlsearch
set incsearch
set ignorecase
set number
set guioptions-=T
syntax on

let mapleader=","
set hidden		" allow buffers with unsaved changes
set mouse=a		" enable mouse scrolling and clicking in iTerm
set wildmenu	" expand vim commands like :tabe
set wildmode=full
set scrolloff=4	" keep 4 lines off the edges of the screen when scrolling
set nobackup	" no backup file clutter
set noswapfile	" never used it
set nomodeline	" ignore vim modelines
"set modeline
set laststatus=2 " always show statusline
"set clipboard+=unnamed " use system clipboard for yanking text
" no delays for ESC please
set timeoutlen=150 ttimeoutlen=0
set nofoldenable

" testing with cursorline
set cursorline

colo solarized
highlight SignColumn ctermbg=lightgrey

" faster buffer switching
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-h> :bp<CR>

" auto fix indent after pasting
nnoremap p p=`]g;

" move up and down 5 rows at a time
noremap <C-y> 5<C-y>
noremap <C-e> 5<C-e>

" tag jump. display list of tags if multiple found
nnoremap <c-]> g<c-]>

" map <leader>/ to turn off search highlight
nnoremap <Leader>/ :noh<CR>

" remap * to only highlight matches and not jump to next match
map * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" ######### Various plugin settings ##################################

let g:ycm_collect_identifiers_from_tags_files = 0

" tell signify to check subrepos
let g:signify_diffoptions = { 'hg': '-S' }
let g:signify_vcs_list = [ 'hg' ]

" incsearch config
"map z/ <Plug>(incsearch-fuzzy-/)

" only check for php errors, not style
let g:syntastic_php_checkers=['php']
" always add error locations to loc_list so we can jump to them
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--max-line-length=160"

" vimwiki
let g:vimwiki_hl_cb_checked = 1
nmap <leader>tt <Plug>VimwikiToggleListItem

map <C-t> :NERDTreeToggle<CR>
" Make NERDTree ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']

" set snippet dir
let g:snippets_dir = '~/code/dotfiles/vimsnippets/'

" set ack options
let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-file=is:.tags"

" set flake8 python linter options
"let g:flake8_show_in_gutter = 1
"let g:flake8_show_in_file = 1
"autocmd BufWritePost *.py call Flake8()

" ######### Airline ##################################

" Configure statusline plugin
let g:airline_theme='solarized'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#show_message = 0

" ######### Tagbar ##################################

" tagbar autofocus and autoclose
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_iconchars = ['▾', '▸']

" only show function names in tagbar
let g:tagbar_type_php = { 'ctagstype' : 'php', 'kinds' : [ 'f:function' ] }

" ######### Ctrl-P config ##################################

map <C-b> :CtrlPBuffer<CR>
map <C-g> :CtrlPBufTag<CR>

" Add ctrlp prompt mapping for pasting previous visual selection
let g:ctrlp_prompt_mappings = { 'PrtInsert("v")': ['<c-q>'] }
" Add C-p shortcut for visual mode to open Ctrl-P and search for selected text
vmap <C-p> <ESC><CR>:CtrlP<CR><c-q>

let g:ctrlp_tabpage_position = 'ac'

" dont look at .hg dirs to decide where current working dir is, messes up with
" subrepos
let g:ctrlp_working_path_mode = '0'

let g:ctrlp_buftag_types = {
    \ 'php'     : '--PHP-kinds=+cf-v',
\ }

" ######### Easytags ##################################

" let easytags look for tags file in project
set tags=./.tags;
let g:easytags_dynamic_files = 1
" disable auto update because it seems to make vim lag
" (use :UpdateTags -R ./*)
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" ######### Functions ##################################

" remove trailing whitespace before saving
fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

" include local vim conf
let s:extrarc = expand($HOME . '/.vimrc.local')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif

" Update tags file for php
function! UpdateTags()
	call system("ctags -R -f .tags --exclude=.hg --tag-relative=yes --PHP-kinds=+cf-v --regex-PHP='/abstract\s+class\s+([^ ]+)/\1/c/' --regex-PHP='/interface\s+([^ ]+)/\1/c/' --regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)function\s+\&?\s*([^ ()]+)/\2/f/' ./*")
	echo 'Tagsfile updated'
endfunction
command! UpdateTags call UpdateTags()

" Mercurial branch
function! MercurialBranch()
	let output = Strip(system('hg branch'))

	if v:shell_error
		return '[none]'
	endif

	return output
endfunction

function! Strip(input_string)
	return substitute(a:input_string, '^\s*\(.\{-}\)\s*\n$', '\1', '')
endfunction

function! Hgdiff()
	call Vcsdiff('hg diff -p')
endfunction

function! Gitdiff()
	call Vcsdiff('git --no-pager diff --cached')
endfunction

function! Vcsdiff(cmd)
	vnew 
	execute 'silent r !' . a:cmd
	0
	"file DIFF
	setlocal nobuflisted
	setlocal filetype=diff
	setlocal buftype=nofile
	setlocal noswapfile
	wincmd w
endfunction

command! Hgdiff call Hgdiff()
command! Gitdiff call Gitdiff()

" ######### Autocmds ##################################

autocmd FileType php,html,smarty,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
