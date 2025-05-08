return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local mason_dap = require("mason-nvim-dap")
      local dap = require("dap")
      local ui = require("dapui")
      local dap_virtual_text = require("nvim-dap-virtual-text")

      dap_virtual_text.setup()

      mason_dap.setup({
        ensure_installed = { "python" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      ui.setup()

      dap.listeners.before.attach.dapui_config = ui.attach
      dap.listeners.before.launch.dapui_config = function() ui.open({ reset = true })  end
      dap.listeners.before.event_terminated.dapui_config = ui.close
      dap.listeners.before.event_exited.dapui_config = ui.close

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Continue" })
      vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Step Over" })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step Into" })
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Step Out" })
      vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Run Last Configuration" })
      vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = "Terminate" })

      vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
      vim.fn.sign_define("DapStopped", { linehl = "DapStoppedLinehl" })
      vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#FF0000" })
      vim.fn.sign_define("DapBreakpoint", { text = "🐞", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

    end
  },
}
