local nvim_lsp = require'nvim_lsp'
local util     = require'nvim_lsp/util'

local chain_complete_list = {
	default = {
		{complete_items = {'lsp', 'snippet'}},
		{complete_items = {'path'}, triggered_only = {'./', '/'}},
		{complete_items = {'buffers'}},
	},
	string = {
		{complete_items = {'path'}, triggered_only = {'./', '/'}},
		{complete_items = {'buffers'}},
	},
	comment = {},
}

local bytemarkers = { {0x7FF, 192}, {0xFFFF, 224}, {0x1FFFFF, 240} }
local function utf8(decimal)
	if decimal < 128 then
		return string.char(decimal)
	end
	local charbytes = {}
	for bytes,vals in ipairs(bytemarkers) do
		if decimal <= vals[1] then
			for b = bytes + 1, 2, -1 do
				local mod = decimal % 64
				decimal = (decimal - mod) / 64
				charbytes[b] = string.char(128 + mod)
			end
			charbytes[1] = string.char(vals[2] + decimal)
			break
		end
	end
	return table.concat(charbytes)
end

local customize_lsp_label = {
	 Method = utf8(0xf794) .. ' [method]',
	 Function = utf8(0xf794) .. ' [function]',
	 Variable = utf8(0xf6a6) .. ' [variable]',
	 Field = utf8(0xf6a6) .. ' [field]',
	 Class = utf8(0xfb44) .. ' [class]',
	 Struct = utf8(0xfb44) .. ' [struct]',
	 Interface = utf8(0xf836) .. ' [interface]',
	 Module = utf8(0xf668) .. ' [module]',
	 Property = utf8(0xf0ad) .. ' [property]',
	 Value = utf8(0xf77a) .. ' [value]',
	 Enum = utf8(0xf77a) .. ' [enum]',
	 Operator = utf8(0xf055) .. ' [operator]',
	 Reference = utf8(0xf838) .. ' [reference]',
	 Keyword = utf8(0xf80a) .. ' [keyword]',
	 Color = utf8(0xe22b) .. ' [color]',
	 Unit = utf8(0xe3ce) .. ' [unit]',
	 Snippet = utf8(0xf68e) .. ' [snippet]',
	 Text = utf8(0xf52b) .. ' [text]',
	 Buffers = utf8(0xf64d) .. ' [buffers]',
	 TypeParameter = utf8(0xf635) .. ' [type]',
}

local on_attach = function(_, _)
	require'diagnostic'.on_attach()
	require'completion'.on_attach({
		chain_complete_list = chain_complete_list,
		customize_lsp_label = customize_lsp_label,
		enable_auto_signatur = 1,
		auto_change_source = 1,
	})
	vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
end

local cap = {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true
			}
		}
	}
}

local lua_settings = {
	Lua = {
		runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true,
			},
		},
	},
}

local function setup_ls(ls, ls_cmd, backup, backup_cmd, passed_settings)
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
			capabilities = cap;
			settings = passed_settings;
		}
	else
		if not (backup == nil) then
			if not (backup_bin == nil) and util.has_bins(backup_bin) then
				backup.setup{
					on_attach = on_attach;
					cmd = backup_arr;
					capabilities = cap;
					settings = passed_settings;
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
setup_ls(nvim_lsp.sumneko_lua, "lua-language-server", nil, nil, lua_settings)
setup_ls(nvim_lsp.sqlls, "sql-language-server")
setup_ls(nvim_lsp.texlab, "texlab")
setup_ls(nvim_lsp.tsserver, { "typescript-language-server", "--stdio" })
setup_ls(nvim_lsp.vimls, { "vim-language-server", "--stdio" })
