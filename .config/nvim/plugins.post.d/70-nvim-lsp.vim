:lua << EOF
	local nvim_lsp = require'nvim_lsp'
	local M = {}

	M.on_attach = function()
	  require'diagnostic'.on_attach()
	  require'completion'.on_attach()
	end

	nvim_lsp.bashls.setup{
		on_attach=M.on_attach;
	}
	nvim_lsp.clangd.setup{
		on_attach=M.on_attach;
	}
	nvim_lsp.pyls.setup{
		on_attach=M.on_attach;
	}
	nvim_lsp.texlab.setup{
		on_attach=M.on_attach;
	}
EOF
