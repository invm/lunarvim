-- vim.cmd [[
-- try
--   colorscheme onedark
--   if exists('+termguicolors')
--     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--     set termguicolors
--     highlight Normal cterm=NONE ctermbg=17 gui=NONE guibg=#282a36
--     let g:dracula_colorterm = 0
--     let g:dracula_italic = 0
--   endif
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]
require('onedark').setup {
    style = 'deep',
}
require('onedark').load()
