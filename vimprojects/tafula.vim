set tabstop=4 
set shiftwidth=4 
set expandtab

" Enable stricter php checking for shopware projects
let g:syntastic_check_on_open = 1
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=psr2'
let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'
let g:syntastic_aggregate_errors = 1

" enable phpactor for shopware because it has a proper composer.json
"Plugin 'phpactor/phpactor'

" vim git integration, might be slow with airline
Plugin 'tpope/vim-fugitive'
