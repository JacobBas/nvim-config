fun! ColorMyPencils()
    if g:colorscheme == "gruvbox"
        let g:gruvbox_contrast_dark = 'medium'
        if exists('+termguicolors')
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif
        let g:gruvbox_invert_selection='0'

        set background=dark
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:colorscheme])

        highlight ColorColumn ctermbg=0 guibg=black
        hi SignColumn guibg=none
        hi CursorLineNR guibg=None
        highlight Normal guibg=none
        highlight LineNr guifg=#ff8659
        highlight LineNr guifg=#aed75f
        highlight LineNr guifg=#5eacd3
        highlight netrwDir guifg=#5eacd3
        highlight qfFileName guifg=#aed75f
        hi TelescopeBorder guifg=#5eacd

    endif

    if g:colorscheme == "github_*"
        let g:github_function_style = "italic"
        let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

        " Change the "hint" color to the "orange" color, and make the "error" color bright red
        let g:github_colors = {
          \ 'hint': 'orange',
          \ 'error': '#ff0000'
        \ }

        colorscheme github_dimmed
    endif

    if g:colorscheme == "kanagawa"
        colorscheme kanagawa
    endif

    " allowing for background transparency
    " hi Normal guibg=NONE ctermbg=NONE
endfun
call ColorMyPencils()

" Vim with me
nnoremap <leader>cmp :call ColorMyPencils()<CR>
nnoremap <leader>vwb :let g:colorscheme =
