local indent = require'snippets.utils'.match_indentation

local bib = {
  ["art"] = indent [[@article{
  author  = {$1},
  year    = {$2},
  title   = {$3},
  journal = {$4},
  volume  = {$5},
  pages   = {$6},
}]],
  ["book"] = indent [[@book{
  author    = {$1},
  year      = {$2},
  title     = {$3},
  publisher = {$4},
}]],
  ["col"] = indent [[@incollection{
  author    = {$1},
  title     = {$2},
  booktitle = {$3},
  editor    = {$4},
  year      = {$5},
  publisher = {$6},
}]],
  ["misc"] = indent [[@Misc{
  title        = {$1},
  note         = {$2},
  url          = {$3},
  howpublished = "\url{$4}",
  key          = {$5},
}]],
}

local m = {}

m.get_snippets = function()
  return bib
end

return m
