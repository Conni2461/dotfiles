local Job = require "plenary.job"
local win_float = require "plenary.window.float"

local m = {}

local opts = { winopts = { winblend = 3 } }

local get_window = function()
  local res = win_float.percentage_range_window(0.95, 0.70, opts.winopts)

  vim.api.nvim_buf_set_keymap(res.bufnr, "n", "q", ":q<CR>", {})

  vim.api.nvim_win_set_option(res.win_id, "winhl", "Normal:Normal")
  vim.api.nvim_win_set_option(res.win_id, "conceallevel", 3)
  vim.api.nvim_win_set_option(res.win_id, "concealcursor", "n")

  if res.border_win_id then
    vim.api.nvim_win_set_option(res.border_win_id, "winhl", "Normal:Normal")
  end
  vim.cmd "mode"
  local chan = vim.api.nvim_open_term(res.bufnr, {})

  return res, chan
end

local gen_gtest_job = function(chan, args)
  local writer = vim.schedule_wrap(function(_, data)
    vim.api.nvim_chan_send(chan, data .. "\r\n")
  end)
  local make = Job:new {
    command = "make",
    on_stdout = writer,
    on_stderr = writer,
    on_exit = function(_, code)
      if code == 0 then
        Job:new({
          command = "./build/test/MPTtest",
          args = args,
          on_stdout = writer,
          on_stderr = writer,
        }):start()
      end
    end,
  }

  return make
end

local run_test = function()
  local file = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local a, b = string.match(file[cursor[1]], "^%s*TEST%(([^,]+),%s([^)]*)%).*$")

  local _, chan = get_window()
  gen_gtest_job(chan, { "--gtest_color=yes", "--gtest_filter=" .. a .. "." .. b }):start()
end

local run_file = function()
  local file = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local i = 1
  local len = #file
  local a = nil
  repeat
    a, _ = string.match(file[i], "^%s*TEST%(([^,]+),%s([^)]*)%).*$")
    i = i + 1
  until a ~= nil or i == len

  local _, chan = get_window()
  gen_gtest_job(chan, { "--gtest_color=yes", "--gtest_filter=" .. a .. "*" }):start()
end

local run_all = function()
  local _, chan = get_window()
  gen_gtest_job(chan, { "--gtest_color=yes" }):start()
end

m.setup = function()
  vim.keymap.set("n", "<leader>rt", run_test, { noremap = true })
  vim.keymap.set("n", "<leader>rf", run_file, { noremap = true })
  vim.keymap.set("n", "<leader>rr", run_all, { noremap = true })
end

return m
