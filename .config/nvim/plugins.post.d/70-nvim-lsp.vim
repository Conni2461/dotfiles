luafile ~/.config/nvim/plugins.post.d/70-nvim-lsp.lua

augroup omnifunc
	au!
	au Filetype sh         setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype c,cpp      setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype css        setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype dockerfile setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype javascript setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype fortran    setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype go         setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype html       setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype json       setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype scala      setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype python     setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype rust       setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype ruby       setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype lua        setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype tex        setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype typescript setl omnifunc=v:lua.vim.lsp.omnifunc
	au Filetype vim        setl omnifunc=v:lua.vim.lsp.omnifunc
augroup END
