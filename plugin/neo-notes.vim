" defining the vim accessible function
fun! Notes()
    " unloading the Notes function so any changes persist through
    lua for k in pairs(package.loaded) do if k:match("neo-notes") then pacakge.loaded[k] = nil end end
    
    " calling the notes function
    lua require("neo-notes").Notes()
endfun

" autogroup commands run when Notes is called
augroup Notes
    autocmd!
augroup END

" creating a new command that calls the lua function
command Notes call Notes()
