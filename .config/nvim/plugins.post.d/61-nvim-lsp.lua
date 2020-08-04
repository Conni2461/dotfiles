local nvim_lsp = require'nvim_lsp'
local util     = require'nvim_lsp/util'

local chain_complete_list = {
	default = {
		{complete_items = {'lsp'}},
		{complete_items = {'path'}, triggered_only = {'./', '/'}},
		{complete_items = {'buffers'}},
	},
	string = {
		{complete_items = {'path'}, triggered_only = {'./', '/'}},
		{complete_items = {'buffers'}},
	},
	comment = {},
}

local customize_lsp_label = {
	 Method = ' [method]',
	 Function = ' [function]',
	 Variable = ' [variable]',
	 Field = ' [field]',
	 Class = 'פּ [class]',
	 Struct = 'פּ [struct]',
	 Interface = ' [interface]',
	 Module = ' [module]',
	 Property = ' [property]',
	 Value = ' [value]',
	 Enum = ' [enum]',
	 Operator = ' [operator]',
	 Reference = ' [reference]',
	 Keyword = ' [keyword]',
	 Color = ' [color]',
	 Unit = ' [unit]',
	 Snippet = ' [snippet]',
	 Text = ' [text]',
	 Buffers = ' [buffers]',
	 TypeParameter = ' [type]',
}

local on_attach = function(_, _)
	require'diagnostic'.on_attach()
	require'completion'.on_attach({
		chain_complete_list = chain_complete_list,
		customize_lsp_label = customize_lsp_label,
		auto_change_source = 1,
	})
	vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
end

local function setup_ls(ls, ls_cmd, backup, backup_cmd)
	local bin, arr
	local backup_bin, backup_arr
	if type(ls_cmd) == "string" then
		bin = ls_cmd
		arr = { ls_cmd }
	else
		bin = ls_cmd[1]
		arr = ls_cmd
	end


	if not (backup_cmd == nil) then
		if type(backup_cmd) == "string" then
			backup_bin = backup_cmd
			backup_arr = { backup_cmd }
		else
			backup_bin = backup_cmd[1]
			backup_arr = backup_cmd
		end
	end

	if util.has_bins(bin) then
		ls.setup{
			on_attach = on_attach;
			cmd = arr;
		}
	else
		if not (backup == nil) then
			if not (backup_bin == nil) and util.has_bins(backup_bin) then
				backup.setup{
					on_attach = on_attach;
					cmd = backup_arr;
				}
			end
		end
	end
end

setup_ls(nvim_lsp.als, "ada_language_server")
setup_ls(nvim_lsp.bashls, { "bash-language-server", "start" })
-- setup_ls(nvim_lsp.ccls, "ccls", nvim_lsp.clangd, "clangd")
setup_ls(nvim_lsp.clangd, { "clangd", "--background-index" }, nil, nil)
setup_ls(nvim_lsp.cmake, "cmake-language-server")
setup_ls(nvim_lsp.cssls, { "css-languageserver", "--stdio" })
setup_ls(nvim_lsp.dockerls, { "docker-langserver", "--stdio" })
setup_ls(nvim_lsp.elixirls, "elixir-ls")
setup_ls(nvim_lsp.flow, {"npm", "run", "flow", "lsp"})
setup_ls(nvim_lsp.fortls, "fortls")
setup_ls(nvim_lsp.gopls, "gopls")
setup_ls(nvim_lsp.html, { "html-languageserver", "--stdio" })
setup_ls(nvim_lsp.jsonls, { "vscode-json-languageserver", "--stdio" })
setup_ls(nvim_lsp.kotlin_language_server, "kotlin-language-server")
setup_ls(nvim_lsp.metals, "metals")
setup_ls(nvim_lsp.pyls_ms, "mspyls", nvim_lsp.pyls, "pyls")
setup_ls(nvim_lsp.r_language_server, { "R", "--slave", "-e", "languageserver::run()" })
setup_ls(nvim_lsp.rust_analyzer, "rust-analyzer", nvim_lsp.rls, "rls")
setup_ls(nvim_lsp.solargraph, { "solargraph", "stdio" })
setup_ls(nvim_lsp.sumneko_lua, "lua-language-server")
setup_ls(nvim_lsp.texlab, "texlab")
setup_ls(nvim_lsp.tsserver, { "typescript-language-server", "--stdio" })
setup_ls(nvim_lsp.vimls, { "vim-language-server", "--stdio" })
