return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    -- 1. Add this dependency to manage DAP adapters with Mason
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'
    require('dapui').setup()
    require('nvim-dap-virtual-text').setup()

    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }
    dap.configurations.c = {
      {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }
    -- Keymaps for dap
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>?', function()
      require('dapui').eval(nil, { enter = true })
    end, { desc = 'DAP Eval' })
    vim.keymap.set('n', '<F1>', dap.continue, { desc = 'DAP Continue' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'DAP Step Into' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'DAP Step Over' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'DAP Step Out' })
    vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'DAP Step Back' })
    vim.keymap.set('n', '<F13>', dap.restart, { desc = 'DAP Restart' })
    -- Add map to open the UI
    vim.keymap.set('n', '<leader>du', ui.toggle, { desc = 'Toggle DAP UI' })

    -- Automatically open/close dap-ui
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
