local nvim_lsp = require'nvim_lsp'
local util     = require'nvim_lsp/util'

local M = {}

M.on_attach = function(_, _)
	require'completion'.on_attach()
	require'diagnostic'.on_attach()
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
			on_attach = M.on_attach;
			cmd = arr;
		}
	else
		if not (backup == nil) then
			if not (backup_bin == nil) and util.has_bins(backup_bin) then
				backup.setup{
					on_attach = M.on_attach;
					cmd = backup_arr;
				}
			end
		end
	end
end

setup_ls(nvim_lsp.als, "ada_language_server")
setup_ls(nvim_lsp.bashls, {"bash-language-server", "start"})
-- setup_ls(nvim_lsp.ccls, "ccls", nvim_lsp.clangd, "clangd")
setup_ls(nvim_lsp.clangd, "clangd", nil, nil)
setup_ls(nvim_lsp.cmake, "cmake-language-server")
setup_ls(nvim_lsp.cssls, "css-languageserver")
setup_ls(nvim_lsp.dockerls, "docker-languageserver")
setup_ls(nvim_lsp.elixirls, "elixir-ls")
setup_ls(nvim_lsp.flow, {"npm", "run", "flow", "lsp"})
setup_ls(nvim_lsp.fortls, "fortls")
setup_ls(nvim_lsp.gopls, "gopls")
setup_ls(nvim_lsp.html, "html-languageserver")
setup_ls(nvim_lsp.jsonls, "vscode-json-languageserver")
setup_ls(nvim_lsp.kotlin_language_server, "kotlin-language-server")
setup_ls(nvim_lsp.metals, "metals")
setup_ls(nvim_lsp.pyls_ms, "mspyls", nvim_lsp.pyls, "pyls")
setup_ls(nvim_lsp.r_language_server, "R")
setup_ls(nvim_lsp.rust_analyzer, "rust-analyzer", nvim_lsp.rls, "rls")
setup_ls(nvim_lsp.solargraph, "solargraph")
setup_ls(nvim_lsp.sumneko_lua, "lua-language-server")
setup_ls(nvim_lsp.texlab, "texlab")
setup_ls(nvim_lsp.tsserver, "typescript-language-server")
setup_ls(nvim_lsp.vimls, "vim-language-server")
