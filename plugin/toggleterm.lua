require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  open_mapping = [[<c-\>]],
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shade_terminal = true,
  shade_factor = 1,
  float_opts = {
    border = 'curved'
  }
}
