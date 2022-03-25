require"toggleterm".setup{
  size = 13,
  open_mapping = [[<c-j>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  float_opts = {
    border = 'curved', 
    -- width = <value>,
    height = 20,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
