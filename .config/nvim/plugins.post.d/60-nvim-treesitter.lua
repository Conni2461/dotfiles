local ts = require'nvim-treesitter.configs'

ts.setup {
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
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
				smart_rename = "grr",
			}
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
			}
		}
	},
	textobjects = { -- syntax-aware textobjects
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner"
			}
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	playground = {
		enable = true,
		updatetime = 25,
		persist_queries = false
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
		'python',
		'regex',
		'rst',
		'ruby',
		'rust',
		'scala',
		'toml',
		'typescript',
		'yaml'
	}
}
