-- initializing our variables
local M = {}
local buf, win
local notes_dir = "~/notes"

function M.Notes()
    -- creating a new buffer to store the text at
    notes_buf = vim.api.nvim_create_buf(false, false)
    toc_buf = vim.api.nvim_create_buf(false, false)

    -- getting the dimensions of the current screen
    local ui = vim.api.nvim_list_uis()[1]

    -- creating the configuration for the window
    local full_dim = {} 
    full_dim.width = ui.width - 20
    full_dim.height = ui.height - 10

    local toc_dim = {}
    local notes_dim = {}

    toc_dim.width = math.floor(.33 * full_dim.width)
    notes_dim.width = full_dim.width - toc_dim.width - 2

    toc_dim.height = full_dim.height
    notes_dim.height = full_dim.height 

    -- defining the configuration for each of the buffers
    local toc_config = {
        relative = 'editor', 
        anchor   = 'NW',

        -- dimensions of the window
        width    = toc_dim.width,
        height   = toc_dim.height,
        row      = 3, 
        col      = 10,

        -- window styles
        style    = '',
        border   = 'rounded'
    }

    local notes_config = {
        relative = 'editor', 
        anchor   = 'NW',

        -- dimensions of the window
        width    = notes_dim.width,
        height   = notes_dim.height,
        row      = 3, 
        col      = 10 + toc_dim.width + 2,

        -- window styles
        style    = '',
        border   = 'rounded'
    }

    -- creating the new window and rendering it to the screen
    win = vim.api.nvim_open_win(toc_buf, true, toc_config)
    win = vim.api.nvim_open_win(notes_buf, true, notes_config)

    -- opening up the notes file within the new buffer; since we are already
    -- focusing on the new buffer, all that we have to do to open the file
    -- into that buffer is the below vim command
    vim.cmd [[e ~/.notes/main.md]]
end

-- returning the module public variables
return M
