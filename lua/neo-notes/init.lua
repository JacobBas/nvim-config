-- how to print lua stuff print(vim.inspect("hello there"))

-- the first thing that we are going to want to do is load the
-- notes file into the buffer so that we can go about editing
-- that file in a window.
-- from there I need to figure out how to actually put the window
-- into a floting window interface so that I can overlay it 
-- on top of everything else.

-- how to use the floating window API:
-- https://neovim.io/doc/user/api.html#api-floatwin

-- documentation for the vim.api namespace:
-- https://neovim.io/doc/user/api.html

-- see if we can do this same thing but make it a term window
-- so that it is easy to work with the terminal within nvim

-- initializing our variables
local M = {}
local buf, win

function M.Notes()
    -- creating a new buffer to store the text at
    buf = vim.api.nvim_create_buf(false, false)

    -- getting the dimensions of the current screen
    local ui = vim.api.nvim_list_uis()[1]

    -- creating the configuration for the window
    local config = {
        relative = 'editor', 
        anchor   = 'NW',

        -- dimensions of the window
        width    = (ui.width - 20), 
        height   = (ui.height - 10), 
        row      = 3, 
        col      = 10,

        -- window styles
        style    = '',
        border   = 'rounded'
    }

    -- creating the new window and rendering it to the screen
    win = vim.api.nvim_open_win(buf, true, config)

    -- opening up the notes file within the new buffer; since we are already
    -- focusing on the new buffer, all that we have to do to open the file
    -- into that buffer is the below vim command
    vim.cmd [[e test.md]]
end

-- returning the module public variables
return M