" Apply colors called at the beginning and when toggling goyo
	function! ApplyColors()
		" Fix visual mode color
		hi Visual ctermfg=234 ctermbg=252 cterm=none

		" Tabs and Spaces colors
		hi Whitespace cterm=none ctermfg=241 ctermbg=none
		hi NonText    cterm=none ctermfg=241 ctermbg=none

		" Cursor Colors
		hi CursorColumn cterm=none ctermfg=none ctermbg=237
		hi CursorLine   cterm=none ctermfg=none ctermbg=237
		hi ColorColumn  cterm=none ctermfg=none ctermbg=237

		" Fix hlsearch coloring
		hi Search ctermfg=234 cterm=bold

		" Split Delimiter
		hi VertSplit cterm=none

		" Fix vim spellchecking
		hi SpellBad   ctermfg=234 cterm=bold
		hi SpellCap   ctermfg=234 cterm=bold
		hi SpellRare  ctermfg=234 cterm=bold
		hi SpellLocal ctermfg=234 cterm=bold

		" Fix vimdiff colors
		hi DiffAdd    ctermfg=234 cterm=bold
		hi DiffDelete ctermfg=234 cterm=bold
		hi DiffChange ctermfg=234 cterm=bold
		hi DiffText   ctermfg=234 cterm=bold

		" Fix folding color
		hi Folded ctermfg=234 cterm=bold

		" Fix tooltip and Clap
		hi Pmenu ctermfg=255 ctermbg=238

		" Fix Git Gutter
		hi! link SignColumn LineNr
		hi  GitGutterAdd    ctermfg=2
		hi  GitGutterChange ctermfg=3
		hi  GitGutterDelete ctermfg=1

		" Set LSP COLORS
		hi LspDiagnosticsError       ctermfg=1
		hi LspDiagnosticsWarning     ctermfg=2
		hi LspDiagnosticsInformation ctermfg=3
	endfunction
	call ApplyColors()
