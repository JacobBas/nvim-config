" defining the vim accessible function
fun! Buffers()
    " unloading the Notes function so any changes persist through
    lua for k in pairs(package.loaded) do if k:match("neo-buff") then pacakge.loaded[k] = nil end end
    
    " calling the notes function
    lua require("neo-buff").Buffers()
endfun

" autogroup commands run when Notes is called
augroup Buffers
    autocmd!
augroup END

" creating a new command that calls the lua function
command Buffers call Buffers()
