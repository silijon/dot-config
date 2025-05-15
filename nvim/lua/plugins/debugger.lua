return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local mason_dap = require('mason-nvim-dap')
      local dap = require('dap')
      local ui = require('dapui')
      local dap_virtual_text = require('nvim-dap-virtual-text')

      dap_virtual_text.setup({})

      mason_dap.setup({
        ensure_installed = { 'python' },
        automatic_installation = true,
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
          python = function(config)
            local venv = os.getenv('VIRTUAL_ENV') or '/usr/bin/python'
            config.adapters = {
              type = 'executable',
              command = venv .. '/bin/python',
              args = { '-m', 'debugpy.adapter' },
            }
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })

      dap.adapters.remote = function(callback, config)
        callback({
          type = 'server',
          host = config.connect.host,
          port = config.connect.port,
        })
      end

      ui.setup()

      dap.listeners.before.attach.dapui_config = function() ui.open({ reset = true })  end
      dap.listeners.before.launch.dapui_config = function() ui.open({ reset = true })  end
      dap.listeners.before.event_terminated.dapui_config = ui.close
      dap.listeners.before.event_exited.dapui_config = ui.close

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "[C]ontinue" })
      vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Step Over" })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step [I]nto" })
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Step [O]ut" })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Run [L]ast Configuration" })
      vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = "Terminate" })
      vim.keymap.set('n', '<leader>dp', function() ui.open({ reset = true }) end, { desc = "O[p]en the debugger" })
      vim.keymap.set('n', '<leader>dq', ui.close, { desc = "[Q]uit the debugger" })

      vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
      vim.fn.sign_define("DapStopped", { linehl = "DapStoppedLinehl" })
      vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#FF0000" })
      vim.fn.sign_define("DapBreakpoint", { text = "🐞", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

    end
  },
}
