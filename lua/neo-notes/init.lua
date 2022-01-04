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
    vim.cmd [[e ~/.notes/main.md]]
end

-- returning the module public variables
return M
