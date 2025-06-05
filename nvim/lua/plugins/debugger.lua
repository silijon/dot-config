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

      local dap = require("dap")
      local dap_utils = require("dap.utils")
      local dapui = require("dapui")

      dap.set_log_level("DEBUG")

      -- Adds inline variable values (super comfy)
      require("nvim-dap-virtual-text").setup({})

      -- Install adapters
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "js" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          python = function(config)
            local venv = os.getenv("VIRTUAL_ENV") or "/usr"
            config.adapters = {
              type = "executable",
              command = venv .. "/bin/python",
              args = { "-m", "debugpy.adapter" },
            }
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      -- Add addtl adapters
      dap.adapters.remote = function(callback, config)
        callback({
          type = "server",
          host = config.connect.host,
          port = config.connect.port,
        })
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}", },
        },
      }

      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach: Running Process",
        processId = dap_utils.pick_process,
        cwd = "${workspaceFolder}"
      })

      -- Useful links for js/ts
      -- https://github.com/gonstoll/dotfiles/blob/master/.config/nvim/lua/plugins/dap.lua
      -- https://github.com/Andrei0872/dotfiles/blob/master/nvim/after/plugin/dap.lua
      -- https://github.com/vercel/next.js/blob/canary/.vscode/launch.json
      dap.configurations.javascript = {
        {
          name = "Launch File",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          skipFiles = {
            "<node_internals>/**",
            "**/node_modules/**",
          },
        },
      }

      dap.configurations.typescript = {
        {
          name = "Launch File",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "tsx",
          skipFiles = {
            "<node_internals>/**",
            "**/node_modules/**",
          },
        },
      }

      -- Attach to running node proc for all node file types
      for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do

        dap.configurations[language] = dap.configurations[language] or {}

        table.insert(dap.configurations[language], {
          type = "pwa-node",
          request = "attach",
          name = "Attach: Running Process",
          processId = dap_utils.pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = {
            "<node_internals>/**",
            "**/node_modules/**",
          },
        })

        table.insert(dap.configurations[language], {
          name = "Attach: Node Inspector",
          type = "pwa-node",
          request = "attach",
          cwd = "${workspaceFolder}",
          port = 9230,
          sourceMaps = true,
          skipFiles = {
            "<node_internals>/**",
            "**/node_modules/**",
          },
        })

      end


      -- UI
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open({ reset = true })  end
      dap.listeners.before.launch.dapui_config = function() dapui.open({ reset = true })  end
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- Keybindings
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[C]ontinue" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step [I]nto" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step [O]ut" })
      vim.keymap.set("n", "<leader>dg", dap.goto_, { desc = "[G]oto Current Debug Position" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run [L]ast Configuration" })
      vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>dp", function() dapui.open({ reset = true }) end, { desc = "O[p]en the Debugger" })
      vim.keymap.set("n", "<leader>dq", dapui.close, { desc = "[Q]uit the Debugger" })

      vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
      vim.fn.sign_define("DapStopped", { linehl = "DapStoppedLinehl" })
      vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#FF0000" })
      vim.fn.sign_define("DapBreakpoint", { text = "🐞", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

    end
  },
}
