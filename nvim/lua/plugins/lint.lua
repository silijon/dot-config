return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')

      -- Setup linters
      lint.linters_by_ft = {
        text = { 'cspell' },
        markdown = { 'markdownlint' },
        python = { 'pylint' },
      }

      -- Run after save, insert leave, etc.
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end
      })

      -- Set python linters to work in virtualenv
      lint.linters.pylint.cmd = 'python'
      lint.linters.pylint.args = {'-m', 'pylint', '-f', 'json', vim.api.nvim_buf_get_name(0)}

    end
  }
}
