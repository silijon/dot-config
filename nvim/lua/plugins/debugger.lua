return {
  {
      "mfussenegger/nvim-dap",
      dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'leoluz/nvim-dap-go',
        'OrangeT/vim-csharp',
        'mfussenegger/nvim-dap-python',
      },
      config = function()
          local dap, dapui = require("dap"), require("dapui")

          -- dapui configuration
          require('dapui').setup({
              layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.4,
                        },
                        {
                            id = "watches",
                            size = 0.35,
                        },
                        {
                            id = "stacks",
                            size = 0.25,
                        },
                    },
                    position = "right",
                    size = 70,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 15,
                },
            },
          })

          -- bind ui and keymaps
          dap.listeners.before.attach.dapui_config = dapui.attach
          dap.listeners.before.launch.dapui_config = function() dapui.open({ reset = true })  end
          dap.listeners.before.event_terminated.dapui_config = dapui.close
          dap.listeners.before.event_exited.dapui_config = dapui.close

          vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
          vim.keymap.set('n', '<leader>dc', dap.continue, {})
          vim.keymap.set('n', '<leader>dn', dap.step_over, {})
          vim.keymap.set('n', '<leader>di', dap.step_into, {})
          vim.keymap.set('n', '<leader>do', dap.step_out, {})
          vim.keymap.set('n', '<leader>dl', dap.run_last, {})
          vim.keymap.set('n', '<leader>dx', dap.terminate, {})

          vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
          vim.fn.sign_define("DapStopped", { linehl = "DapStoppedLinehl" })
          vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#FF0000" })
          vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

          -- allow for .vscode/launch.json configurations
          -- require('dap.ext.vscode').load_launchjs(nil, { coreclr = { 'cs' } })

          -- specific language configurations
          -- go
          require('dap-go').setup()

          -- csharp
          dap.adapters.coreclr = {
            type = 'executable',
            command = '/home/john/.local/bin/netcoredbg',
            args = {'--interpreter=vscode'}
          }

          -- python
          require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

      end
  },
}
