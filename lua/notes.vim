fun! Notes()
    lua for k in pairs(package.loaded) do if k:match("notes") then pacakge.loaded[k] = nil end end
    lua require("notes").Notes
endfun

augroup Notes
    autocmd!
augroup END
