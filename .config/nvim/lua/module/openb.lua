local Job = require("plenary.job")

local m = {}

local pages = {
  cppref = "https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=",
  qt = "https://doc.qt.io/qt-5/search-results.html?q="
}

m.smart_search = function(key, search)
  search = vim.F.if_nil(search, vim.fn.expand("<cword>"))
  local url = pages[key]
  if url == nil then
    print("key couldn't be found")
    return
  end

  Job:new({ "firefox", url .. search }):start()
end

return m
