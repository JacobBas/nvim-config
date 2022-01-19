-- initializing our variables
local M = {}
local buf, win

local function getBuffList()
    -- getting the list of buffers
    local buffers = vim.api.nvim_list_bufs()
    
    -- looping through and creating the data structure
    local bufferList = {}
    for _, buffId in ipairs(buffers) do
        -- pulling out the name from the buffer
        local name = vim.api.nvim_buf_get_name(buffId)

        -- checking if the buffer is currently loaded
        if (vim.api.nvim_buf_is_loaded(buffId)) then

            -- checking if it is a valid buffer name
            if (name ~= "") then
                table.insert(bufferList, {
                    id = buffId,
                    name = name 
                })
            end
        end
    end

    -- returning out the final buffer list
    return bufferList
end

function M.Buffers()
    -- getting a list of the currently available buffers
    local bufferList = getBuffList()

    -- creating a new buffer to store the text at
    local buf = vim.api.nvim_create_buf(false, true)

    -- getting the dimensions of the current screen
    local ui = vim.api.nvim_list_uis()[1]
    local width = ui.width - 40
    local margin = (ui.width - width) / 2

    -- height is equal to the number of available buffers + 1
    local height = #(bufferList) + 1

    print(vim.inspect(bufferList))

    -- creating the configuration for the window
    local config = {
        relative = 'editor', 
        anchor   = 'NW',

        -- dimensions of the window
        width    = width, 
        height   = height, 
        row      = 0, 
        col      = margin,

        -- window styles
        style    = 'minimal',
        border   = 'shadow'
    }

    -- creating the new window and rendering it to the screen
    win = vim.api.nvim_open_win(buf, true, config)
end

M.Buffers()
