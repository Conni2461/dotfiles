autocmd Filetype c inoremap ,in #include<><ESC>0f<a
autocmd Filetype c inoremap ,de #define<space>
autocmd Filetype c inoremap ,id #ifndef<space><++><Enter>#define<space><++><Enter>#endif<ESC>2k0f<i
autocmd Filetype c inoremap ,ma int main(int argc, char *argv[])<Enter>{<Enter><Enter>return 0;<Enter>}<ESC>2kli
autocmd Filetype c inoremap ,st typedef struct<space>{<Enter><Enter>}<++>;<ESC>0f<i
autocmd Filetype c inoremap ,en enum <++> {<Enter><Enter>};<ESC>2k0f<
