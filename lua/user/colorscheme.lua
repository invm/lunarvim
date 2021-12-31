vim.cmd [[
try
  colorscheme dracula
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  highlight Normal cterm=NONE ctermbg=17 gui=NONE guibg=#282a36
  let g:dracula_colorterm = 0
  let g:dracula_italic = 0
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
