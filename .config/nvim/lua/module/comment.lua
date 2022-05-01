require("Comment.ft").set("lua", { "--%s", "--[[%s]]" })
require("Comment").setup {
  ignore = nil,
  opleader = {
    line = "gc",
    block = "gb",
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  post_hook = nil,
}
