Plug 'mhinz/vim-startify'

function! s:gitModified()
	let files = systemlist('git ls-files -m 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
	let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
	\ { 'type': 'files',                    'header': ['   MRU']            },
	\ { 'type': 'dir',                      'header': ['   MRU '. getcwd()] },
	\ { 'type': 'sessions',                 'header': ['   Sessions']       },
	\ { 'type': 'bookmarks',                'header': ['   Bookmarks']      },
	\ { 'type': function('s:gitModified'),  'header': ['   Git Modified']   },
	\ { 'type': function('s:gitUntracked'), 'header': ['   Git Untracked']  },
	\ { 'type': 'commands',                 'header': ['   Commands']       },
\ ]

let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_autoload = 'no'

nnoremap <leader>so :SLoad<Space>
nnoremap <leader>ss :SSave<Space>
nnoremap <leader>sd :SDelete<CR>
nnoremap <leader>sc :SClose<CR>
