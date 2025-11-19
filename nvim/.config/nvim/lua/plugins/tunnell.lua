return {
  {
    'sourproton/tunnell.nvim',
    opts = {
      cell_header = '# %%',
      tmux_target = '2',
    },

    -- to lazy-load on keymaps:
    keys = {
      -- suggestions for keymaps:
      { '<leader>tn', ':TunnellCell<CR>', mode = { 'n' }, desc = 'Tunnell cell' },
      { '<leader>tn', ':TunnellRange<CR>', mode = { 'v' }, desc = 'Tunnell range' },
      -- { '<leader>tc', ':TunnellConfig<CR>', mode = { 'n' }, desc = 'Tunnell config' },
    },

    -- to lazy-load on commands:
    cmd = {
      'TunnellCell',
      'TunnellRange',
      'TunnellConfig',
    },
  },
}
