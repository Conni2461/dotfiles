Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Exit clap with esc rather than going to normal mode
au FileType clap_input inoremap <silent> <buffer> <Esc> <Esc>:call clap#handler#exit()<CR>

nnoremap <leader>q  :Clap files<CR>
nnoremap <leader>z  :Clap filer<CR>
nnoremap <leader>bg :Clap buffers<CR>
nnoremap <leader>gp :Clap grep<CR>
nnoremap <leader>gw :Clap grep ++query=<cword><CR>
nnoremap <leader>t  :Clap tags<CR>
nnoremap <leader>'  :Clap marks<CR>
let g:clap_theme = 'material_design_dark'

function! s:ReadBib(...)
	let l:input = join(a:000)
	let l:command = "echo '" . l:input . "' | cut -d':' -f 1"
	let l:file = system(l:command)

	execute 'read !loadbib -g' l:file
endfunction

command! -nargs=* ReadBib call s:ReadBib(<f-args>)

" Own Clap provider
let g:clap_provider_quick_open = {
	\ 'source': ['~/.aliasrc', '~/.functionrc', '~/.bashrc', '~/.profile', '~/.gitconfig', '~/.config/nvim/init.vim', '~/.tmux.conf'],
	\ 'sink': 'e',
	\ }

let g:clap_provider_load_bib = {
	\ 'source': 'loadbib -l',
	\ 'sink': 'ReadBib',
	\ }

nnoremap <leader>xo  :Clap quick_open<CR>
nnoremap <leader>xb  :Clap load_bib<CR>
