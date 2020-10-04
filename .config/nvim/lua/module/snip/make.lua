-- TODO: Require completion engine enabled for Makefiles
-- We have to do this for every filetype which does not have a lsp(markdown, etc...)
-- Should be autocmd Filetype make setlocal lua require'completion'...

local U = require'snippets.utils'

local make = {
}

local m = {}

m.get_snippets = function()
  return make
end

return m
