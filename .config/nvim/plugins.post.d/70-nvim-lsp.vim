:lua << EOF
	local nvim_lsp = require'nvim_lsp'
	nvim_lsp.bashls.setup{
		log_level = vim.lsp.protocol.MessageType.Log;
		message_level = vim.lsp.protocol.MessageType.Log;
		on_attach=require'diagnostic'.on_attach;
	}
	nvim_lsp.ccls.setup{
		log_level = vim.lsp.protocol.MessageType.Log;
		message_level = vim.lsp.protocol.MessageType.Log;
		on_attach=require'diagnostic'.on_attach;
	}
	nvim_lsp.pyls.setup{
		log_level = vim.lsp.protocol.MessageType.Log;
		message_level = vim.lsp.protocol.MessageType.Log;
		on_attach=require'diagnostic'.on_attach;
	}
	nvim_lsp.texlab.setup{
		log_level = vim.lsp.protocol.MessageType.Log;
		message_level = vim.lsp.protocol.MessageType.Log;
		on_attach=require'diagnostic'.on_attach;
	}
EOF
