local U = require'snippets.utils'

local cpp = {
  -- TMP TEST VALUE
  cout = [[std::cout << $0 << std::endl;]],
}

local m = {}

m.get_snippets = function()
  return vim.tbl_extend('force', require('module/snip/c').get_snippets(), cpp)
end

return m
