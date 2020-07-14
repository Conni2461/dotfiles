local ts = require'nvim-treesitter.configs'

ts.setup {
	highlight = {
		enable = true,                    -- false will disable the whole extension
		-- disable = { 'c', 'rust' },     -- list of language that will be disabled
	},
	incremental_selection = {
		enable = true,
		-- disable = { 'cpp', 'lua' },    -- list of language that will be disabled
		keymaps = {                       -- mappings for incremental selection (visual mappings)
			init_selection = 'gnn',       -- maps in normal mode to init the node/scope selection
			node_incremental = "grn",     -- increment to the upper named parent
			scope_incremental = "grc",    -- increment to the upper scope (as defined in locals.scm)
			node_decremental = "grm",     -- decrement to the previous node
		}
	},
	refactor = {
		highlight_definitions = {
			enable = true
		},
		highlight_current_scope = {
			enable = false
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",     -- mapping to rename reference under cursor
			}
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",  -- mapping to go to definition of symbol under cursor
				list_definitions = "gnD", -- mapping to list all definitions in current file
			}
		}
	},
	ensure_installed = { -- one of 'all', 'language' or a list of languages
		'bash',
		'c',
		'cpp',
		'css',
		'c_sharp',
		'go',
		'html',
		'java',
		'javascript',
		'json',
		'lua',
		'markdown',
		'python',
		'regex',
		'ruby',
		'rust',
		'scala',
		'toml',
		'typescript',
		'yaml'
	}
}
