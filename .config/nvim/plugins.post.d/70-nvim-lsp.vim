:lua << EOF
	local nvim_lsp = require'nvim_lsp'
	local M = {}

	M.on_attach = function()
	  require'diagnostic'.on_attach()
	  require'completion'.on_attach()
	end

	nvim_lsp.bashls.setup{ on_attach = M.on_attach; }
	nvim_lsp.clangd.setup{ on_attach = M.on_attach; }
	nvim_lsp.cssls.setup{ on_attach = M.on_attach; }
	nvim_lsp.dockerls.setup{ on_attach = M.on_attach; }
	nvim_lsp.flow.setup{ on_attach = M.on_attach; }
	nvim_lsp.fortls.setup{ on_attach = M.on_attach; }
	nvim_lsp.gopls.setup{ on_attach = M.on_attach; }
	nvim_lsp.html.setup{ on_attach = M.on_attach; }
	nvim_lsp.jsonls.setup{ on_attach = M.on_attach; }
	nvim_lsp.metals.setup{ on_attach = M.on_attach; }
	nvim_lsp.pyls.setup{ on_attach = M.on_attach; }
	nvim_lsp.pyls_ms.setup{
		on_attach = M.on_attach;
		cmd = { "/usr/bin/mspyls" };
	}
	nvim_lsp.rls.setup{ on_attach = M.on_attach; }
	nvim_lsp.rust_analyzer.setup{ on_attach = M.on_attach; }
	nvim_lsp.solargraph.setup{ on_attach = M.on_attach; }
	nvim_lsp.sumneko_lua.setup{
		on_attach = M.on_attach;
		cmd = { "/usr/bin/lua-language-server" };
	}
	nvim_lsp.texlab.setup{ on_attach = M.on_attach; }
	nvim_lsp.tsserver.setup{ on_attach = M.on_attach; }
	nvim_lsp.vimls.setup{ on_attach = M.on_attach; }
EOF

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
