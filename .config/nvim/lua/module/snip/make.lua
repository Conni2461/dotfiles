-- TODO: Require completion engine enabled for Makefiles
-- We have to do this for every filetype which does not have a lsp(markdown, etc...)
-- Should be autocmd Filetype make setlocal lua require'completion'...

local indent = require'snippets.utils'.match_indentation

local make = {
  base = [[
.PHONY: clean, mrproper
CC = gcc
CFLAGS = -g -Wall

all: $1

%.o: %.c
	\$(CC) \$(CFLAGS) -c -o \$@ \$<

${1:out}: $1.o
	\$(CC) \$(CFLAGS) -o \$@ \$+

clean:
	rm -f *.o core.*

veryclean: clean
	rm -f $1]],
  add = indent [[
${1:out}: $1.o
	\$(CC) \$(CFLAGS) -o \$@ \$+]],
  print = [[print-%: ; @echo \$*=\$(\$*)]],
  ["if"] = indent [[
ifeq (${1:cond0}, ${2:cond1})
	$0
endif]],
  ife = indent [[
ifeq (${1:cond0}, ${2:cond1})
	$3
else
	$0
endif]],
  el = indent [[
else
	$0]],
  default = [[.DEFAULT_GOAL := $1]],
  help = indent [[
help: ## Prints help for targets with comments
	@cat \$(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*\$\$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", \$\$1, \$\$2}']],
}

local m = {}

m.get_snippets = function()
  return make
end

return m
