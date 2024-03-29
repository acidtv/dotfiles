set nocompatible               " be iMproved
filetype off                   " required!

" fix weird character bug? https://github.com/neovim/neovim/issues/5990
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-markdown'
"Plugin 'lumiliet/vim-twig'

Plugin 'bling/vim-airline'
Plugin 'mileszs/ack.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-signify'
Plugin 'vimwiki/vimwiki'
Plugin 'spiiph/vim-space'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Shougo/vimproc.vim'

Plugin 'tpope/vim-surround'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'thinca/vim-ref'
"Plugin 'chrisbra/csv.vim'
"Plugin 'shawncplus/phpcomplete.vim'
Plugin 'mbbill/undotree'
"Plugin 'alvan/vim-php-manual'
" phpactor cannot handle the orbit sourcecode
"Plugin 'phpactor/phpactor'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
"Plugin 'swekaj/php-foldexpr.vim'
Plugin 'numirias/semshi'

" Make sure nodejs is installed!
" After :PluginInstall go to ~/.vim/bundle/coc.nvim/ and execute `yarn install -frozen-lockfile`
" Then:
" :CocInstall coc-css
" :CocInstall coc-html
" :CocInstall coc-phpls
" :CocInstall coc-tsserver
" :CocInstall coc-diagnostic
Plugin 'neoclide/coc.nvim'

"slow with airline
""Plugin 'ludovicchabant/vim-lawrencium'
"Plugin 'tpope/vim-fugitive'

" vim-scripts repos
Plugin 'AutoClose'
"Plugin 'taglist.vim'

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
""set timeoutlen=150 ttimeoutlen=0
set nofoldenable

" vim-fugitive uses this setting as well
set diffopt+=vertical

" hopefully gets rid of '2 q' garbage chars in tmux
" UPDATE: doesnt seem to work, but leaving it here anyway
"set guicursor=
"let $VTE_VERSION = "100"

" testing with cursorline
set cursorline

colo solarized

if $LIGHT_MODE == "dark"
	set background=dark
else
	set background=light
endif

highlight clear SignColumn
highlight VertSplit ctermbg=NONE guibg=NONE

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

" disable signify by default. enable with :SignifyToggle
let g:signify_disable_by_default = 1

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

" NERDTree
map <C-t> :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
" Make NERDTree ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']

" set snippet dir
let g:snippets_dir = '~/code/dotfiles/vimsnippets/'

" set ack options
let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-file=is:.tags --follow"

" set flake8 python linter options
"let g:flake8_show_in_gutter = 1
"let g:flake8_show_in_file = 1
"autocmd BufWritePost *.py call Flake8()

" php online manual shortcut
let g:php_manual_online_search_shortcut = '<C-q>'

let g:PHP_noArrowMatching = 1

" ######### COC ######################################
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"
" ######### Airline ##################################

" Configure statusline plugin
let g:airline_theme='solarized'
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
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
"
"map <C-b> :CtrlPBuffer<CR>
"map <C-g> :CtrlPBufTag<CR>
"
"" Add ctrlp prompt mapping for pasting previous visual selection
"let g:ctrlp_prompt_mappings = { 'PrtInsert("v")': ['<c-q>'] }
"" Add C-p shortcut for visual mode to open Ctrl-P and search for selected text
"vmap <C-p> <ESC><CR>:CtrlP<CR><c-q>
"
"let g:ctrlp_tabpage_position = 'ac'
"
"" dont look at .hg dirs to decide where current working dir is, messes up with
"" subrepos
"let g:ctrlp_working_path_mode = '0'
"
"let g:ctrlp_buftag_types = {
"    \ 'php'     : '--PHP-kinds=+cf-v',
"\ }
"
"" attempt to restore old :CtrlPBuffer behavior
"let g:ctrlp_bufname_mod = ':~:.:p'
"let g:ctrlp_bufpath_mod = ''
"
"let g:ctrlp_open_multiple_files = 'ij'

" ######### FZF config ##################################

map <C-p> :Files<CR>
map <C-b> :Buffers<CR>
"map <C-g> :BTags<CR>
" Same as :BTags but shows only functions
map <C-g> :call fzf#vim#buffer_tags('', { 'options': ['--nth', '..-2,-1', '--query', '^f$ '] })<CR>


let $FZF_DEFAULT_COMMAND='ag -f -g ""'

" ######### Easytags ##################################

" let easytags look for tags file in project
" search for tagsfile current file dir, after that in current dir (pwd)
"set tags=./.tags,.tags
set tags=.tags
let g:easytags_dynamic_files = 1
" disable auto update because it seems to make vim lag
" (use :UpdateTags -R ./*)
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" ######### vim-tmux-navigator #########################

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap <silent> <m-\> :TmuxNavigatePrevious<cr>

" ######### phpactor #########################

augroup PhpactorMappings
	au!
	au FileType php nmap <buffer> <Leader>u :PhpactorImportClass<CR>
	"au FileType php nmap <buffer> <Leader>e :PhpactorClassExpand<CR>
	au FileType php nmap <buffer> <Leader>ua :PhpactorImportMissingClasses<CR>
	au FileType php nmap <buffer> <Leader>mm :PhpactorContextMenu<CR>
	au FileType php nmap <buffer> <Leader>nn :PhpactorNavigate<CR>
    au FileType php nmap <buffer> <Leader>t :PhpactorGotoType<CR>
	au FileType php,cucumber nmap <buffer> <Leader>o
				\ :PhpactorGotoDefinition<CR>
	"au FileType php,cucumber nmap <buffer> <Leader>Oh
				"\ :PhpactorGotoDefinitionHsplit<CR>
	"au FileType php,cucumber nmap <buffer> <Leader>Ov
				"\ :PhpactorGotoDefinitionVsplit<CR>
	"au FileType php,cucumber nmap <buffer> <Leader>Ot
				"\ :PhpactorGotoDefinitionTab<CR>
	au FileType php nmap <buffer> <Leader>K :PhpactorHover<CR>
	au FileType php nmap <buffer> <Leader>tt :PhpactorTransform<CR>
	au FileType php nmap <buffer> <Leader>cc :PhpactorClassNew<CR>
	"au FileType php nmap <buffer> <Leader>ci :PhpactorClassInflect<CR>
	au FileType php nmap <buffer> <Leader>fr :PhpactorFindReferences<CR>
	"au FileType php nmap <buffer> <Leader>mf :PhpactorMoveFile<CR>
	"au FileType php nmap <buffer> <Leader>cf :PhpactorCopyFile<CR>
	au FileType php nmap <buffer> <silent> <Leader>ee
				\ :PhpactorExtractExpression<CR>
	au FileType php vmap <buffer> <silent> <Leader>ee
				\ :<C-u>PhpactorExtractExpression<CR>
	au FileType php vmap <buffer> <silent> <Leader>em
				\ :<C-u>PhpactorExtractMethod<CR>
augroup END

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
	call system("ctags -R -f .tags --exclude=.hg --exclude='bower_components' --exclude='node_modules' --exclude='*min.js' --tag-relative=yes 
				\ --PHP-kinds=+citf-v 
				\ ./*")
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
"
" Mercurial bookmark
function! MercurialBookmark()
	let output = Strip(system('hg id -B | cut -f1 -d" "'))
	return output
endfunction

function! Strip(input_string)
	return substitute(a:input_string, '^\s*\(.\{-}\)\s*\n$', '\1', '')
endfunction

function! Hgdiff()
	let book = toupper(MercurialBookmark())

	" Check if bookmark name matches issue numer format,
	" and if it does add it to the commit message
	if book =~ 'DEV-\d\+'
		call append(0, '#' . book. ': ')
		call cursor(1, 0)
	endif

	call Vcsdiff('hg diff -Sp')
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

function! ProjectInit()
	let projectfolder = expand($HOME . '/code/dotfiles/vimprojects/')
	let dotproject = '.vimproject'

	if filereadable(dotproject)
		let project = readfile(dotproject) 
		let valid = matchstr(project[0], '^[a-z]\+$')

		if empty(valid) 
			throw "Project name can only contain lower case letters."
		endif

		let projectfile = projectfolder . project[0] . '.vim'

		if filereadable(projectfile)
			execute 'source ' . projectfile
			"echo 'Read ' . project[0] . ' projectfile.'
		endif
	endif
endfunction

command! Hgdiff call Hgdiff()
command! Gitdiff call Gitdiff()
command! ProjectInit call ProjectInit()

" ######### Autocmds ##################################

"autocmd FileType php,html,smarty,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" ######### INIT ##################################

call ProjectInit()

