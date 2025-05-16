return {
  {
    'github/copilot.vim',
    config = function()
        vim.keymap.set('i', '<C-t>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require('CopilotChat').setup({})
      local chat = require("CopilotChat")
      vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = 'Toggle [C]opilot [C]hat Window' })
    end,
  },
}
