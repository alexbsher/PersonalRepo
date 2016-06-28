syntax on
set mouse=a
set nu
set autoindent
set incsearch
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
execute pathogen#infect()
let g:netrw_liststyle=3
nnoremap <F5> :buffers<CR>:buffer<Space>
autocmd BufWritePre <buffer> :%s/\s\+$//e
set wildmenu " Show possible tab completions
set complete=.,w,b,u,t,i " Autocomplete via tags

map <C-J> <C-w>w
map <C-K> <C-W>W

"Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

" Line Length 120 characters (Vecna Standard)
autocmd FileType c,cpp,java,php,python,launch,sql,js match ErrorMsg '\%>120v.\+'
:imap jj <Esc>

set textwidth=0 wrapmargin=0
