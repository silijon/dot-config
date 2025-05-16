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
      lint.linters.pylint.cmd = "python"
      lint.linters.pylint.args = {"-m", "pylint", "-f", "json", "--from-stdin", function() return vim.api.nvim_buf_get_name(0) end, }

      -- Disable annoying overly pedantic rules
      -- lint.linters.markdownlint.args = { "--disable", "MD013", "--", function() return vim.api.nvim_buf_get_name(0) end, }

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end)

    end
  }
}
