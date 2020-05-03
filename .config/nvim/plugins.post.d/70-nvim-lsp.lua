local nvim_lsp = require'nvim_lsp'
local util = require 'nvim_lsp/util'
local M = {}

M.on_attach = function()
  require'diagnostic'.on_attach()
  require'completion'.on_attach()
end

if util.has_bins("ada_language_server") then
	nvim_lsp.als.setup{ on_attach = M.on_attach; }
end

if util.has_bins("bash-language-server") then
	nvim_lsp.bashls.setup{ on_attach = M.on_attach; }
end

-- C/C++ setup. Use ccls if installed otherwise clangd
if util.has_bins("ccls") then
	nvim_lsp.ccls.setup{ on_attach = M.on_attach; }
else
	nvim_lsp.clangd.setup{ on_attach = M.on_attach; }
end

if util.has_bins("css-languageserver") then
	nvim_lsp.cssls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("docker-langserver") then
	nvim_lsp.dockerls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("npm") then
	nvim_lsp.flow.setup{ on_attach = M.on_attach; }
end

if util.has_bins("fortls") then
	nvim_lsp.fortls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("gopls") then
	nvim_lsp.gopls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("html-languageserver") then
	nvim_lsp.html.setup{ on_attach = M.on_attach; }
end

if util.has_bins("vscode-json-languageserver") then
	nvim_lsp.jsonls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("kotlin-language-server") then
	nvim_lsp.kotlin_language_server.setup{
		on_attach = M.on_attach;
		cmd = {"kotlin-language-server"};
	}
end

if util.has_bins("metals") then
	nvim_lsp.metals.setup{ on_attach = M.on_attach; }
end

-- Python setup. Use mspyls if installed otherwise pyls
if util.has_bins("mspyls") then
	nvim_lsp.pyls_ms.setup{
		on_attach = M.on_attach;
		cmd = { "/usr/bin/mspyls" };
	}
else
	nvim_lsp.pyls.setup{ on_attach = M.on_attach; }
end

-- Rust setup. Use rust_analyzer if installed otherwise rls
if util.has_bins("rust-analyzer") then
	nvim_lsp.rust_analyzer.setup{ on_attach = M.on_attach; }
else
	nvim_lsp.rls.setup{ on_attach = M.on_attach; }
end

if util.has_bins("solargraph") then
	nvim_lsp.solargraph.setup{ on_attach = M.on_attach; }
end

if util.has_bins("lua-language-server") then
	nvim_lsp.sumneko_lua.setup{
		on_attach = M.on_attach;
		cmd = { "lua-language-server" };
	}
end

if util.has_bins("texlab") then
	nvim_lsp.texlab.setup{ on_attach = M.on_attach; }
end

if util.has_bins("typescript-language-server") then
	nvim_lsp.tsserver.setup{ on_attach = M.on_attach; }
end

if util.has_bins("vim-language-server") then
	nvim_lsp.vimls.setup{ on_attach = M.on_attach; }
end
