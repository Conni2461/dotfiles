local dap = require'dap'

local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

dap.adapters.python = {
  type = 'executable',
  command = '/usr/bin/python',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function(_)
      return '/usr/bin/python'
    end,
  },
}

dap.configurations.cpp = {
  {
    type = 'cpp',
    name = "Launch",
    request = "launch",
    -- program = table.remove(args, 1),
    args = args,
    cwd = vim.fn.getcwd(),
    environment = {},
    externalConsole = true,
    MIMode = mi_mode or "lldb",
    MIDebuggerPath = mi_debugger_path
  },
}

-- Enable virutal text, requires theHamsta/nvim-dap-virutal-text
vim.g.dap_virtual_text = true

mapper('n', '<F3>', '<cmd>lua require\'dap\'.stop()<CR>')
mapper('n', '<F5>', '<cmd>lua require\'dap\'.continue()<CR>')
mapper('n', '<F10>', '<cmd>lua require\'dap\'.step_over()<CR>')
mapper('n', '<F11>', '<cmd>lua require\'dap\'.step_into()<CR>')
mapper('n', '<F12>', '<cmd>lua require\'dap\'.step_out()<CR>')
mapper('n', '<F12>', '<cmd>lua require\'dap\'.step_out()<CR>')
mapper('n', '<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
mapper('n', '<leader>dc', '<cmd>lua require\'dap\'.toggle_breakpoint(vim.fn.input(\'Breakpoint Condition: \'), nil, nil, true)<CR>')
mapper('n', '<leader>dl', '<cmd>lua require\'dap\'.toggle_breakpoint(nil, nil, vim.fn.input(\'Log point message: \'), true)<CR>')
mapper('n', '<leader>dr', '<cmd>lua require\'dap\'.repl.toggle({height=15})<CR>')
vim.cmd('command! -nargs=0 DapBreakpoints :lua require\'dap\'.list_breakpoints()')
