function status_line()
    return table.concat {
    "%#DiffAdd#%{(mode()=='n')?'  NORMAL ':''}",
    "%#DiffChange#%{(mode()=='i')?'  INSERT ':''}",
    "%#DiffDelete#%{(mode()=='r')?'  RPLACE ':''}",
    "%#Cursor#%{(mode()=='v')?'  VISUAL ':''}",
    "  %n ",
    "%#Visual#",
    "%{&paste?' PASTE ':''}",
    "%{&spell?' SPELL ':''}",
    "%#CursorIM#",
    "%R",
    "%M",
    "%#Cursor#",
    "%#CursorLine#",
    "  %t ",
    "%=",
    "%#CursorLine#",
    "  %Y ",
    "%#CursorIM#",
    "  %3l:%-2c ",
    "%#Cursor#",
    "  %3p%% "
    }
end

vim.o.statusline = "%!luaeval('status_line()')"
