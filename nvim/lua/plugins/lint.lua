return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      ignore_errors = false
    },
    config = function()
      local lint = require("lint")

      -- Setup linters
      lint.linters_by_ft = {
        text = { "cspell" },
        markdown = { "markdownlint" },
        python = { "pylint" },
      }

      -- Run after save, insert leave, etc.
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end
      })

      -- Set python linters to work in virtualenv
      local venv = os.getenv('VIRTUAL_ENV') or '/usr'
      lint.linters.pylint.cmd = venv .. "/bin/python"
      lint.linters.pylint.args = { "-m", "pylint", "-f", "json", "--from-stdin", function() return vim.api.nvim_buf_get_name(0) end, }

      -- Disable annoying overly pedantic rules
      lint.linters.markdownlint.args = { "--stdin", "--disable", "MD013", "--", }

      vim.keymap.set("n", "<leader>fl", lint.try_lint, { desc = "[L]int Current Buffer" })
      vim.keymap.set("n", "<leader>fs", function() lint.try_lint("cspell") end, { desc = "[S]pellcheck Current Buffer" })

    end
  }
}
