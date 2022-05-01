local dap = require "dap"

local mapper = function(mode, key, result)
  vim.keymap.set(mode, key, result, { noremap = true, silent = true })
end

dap.adapters.cpp = {
  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "lldb-vscode",
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
  name = "lldb",
}

dap.adapters.python = {
  type = "executable",
  command = "/usr/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.adapters.nlua = function(callback, config)
  callback { type = "server", host = config.host, port = config.port }
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function(_)
      return "/usr/bin/python"
    end,
  },
}

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input "Host [127.0.0.1]: "
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input "Port: ")
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.configurations.cpp = {
  {
    type = "cpp",
    name = "Launch",
    request = "launch",
    -- program = table.remove(args, 1),
    args = args,
    cwd = vim.fn.getcwd(),
    environment = {},
    externalConsole = true,
    MIMode = mi_mode or "lldb",
    MIDebuggerPath = mi_debugger_path,
  },
}

-- Enable virutal text, requires theHamsta/nvim-dap-virutal-text
-- vim.g.dap_virtual_text = true

mapper("n", "<F3>", dap.stop)
mapper("n", "<F5>", dap.continue)
mapper("n", "<F10>", dap.step_over)
mapper("n", "<F11>", dap.step_into)
mapper("n", "<F12>", dap.step_out)
mapper("n", "<F12>", dap.step_out)
mapper("n", "<leader>db", dap.toggle_breakpoint)
mapper("n", "<leader>dc", function()
  dap.toggle_breakpoint(vim.fn.input "Breakpoint Condition: ", nil, nil, true)
end)
mapper("n", "<leader>dl", function()
  dap.toggle_breakpoint(nil, nil, vim.fn.input "Log point message: ", true)
end)
mapper("n", "<leader>dr", function()
  dap.repl.toggle { height = 15 }
end)
vim.api.nvim_create_user_command("DapBreakpoints", function(opts)
  dap.list_breakpoints()
end, { nargs = 0 })
