require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
vim.opt.laststatus = 3 
vim.cmd('highlight WinSeparator guibg=None')

-- function status_line()
--     return table.concat {
--     "%#DiffAdd#%{(mode()=='n')?'  NORMAL ':''}",
--     "%#DiffChange#%{(mode()=='i')?'  INSERT ':''}",
--     "%#DiffDelete#%{(mode()=='r')?'  RPLACE ':''}",
--     "%#Cursor#%{(mode()=='v')?'  VISUAL ':''}",
--     "  %n ",
--     "%#Visual#",
--     "%{&paste?' PASTE ':''}",
--     "%{&spell?' SPELL ':''}",
--     "%#CursorIM#",
--     "%R",
--     "%M",
--     "%#Cursor#",
--     "%#CursorLine#",
--     "  %F ",
--     "%=",
--     "%#CursorLine#",
--     "  %Y ",
--     "%#CursorIM#",
--     "  %3l:%-2c ",
--     "%#Cursor#",
--     "  %3p%% "
--     }
-- end

-- vim.o.statusline = "%!luaeval('status_line()')"
