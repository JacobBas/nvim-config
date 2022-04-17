require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shade_terminal = true,
  shade_factor = 1,
  float_opts = {
    border = 'curved'
  }
}
