return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  { -- Git commands in vim
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>g", "<cmd>Git<CR>", { desc = "[G]it Status" })
    end,
  },
}
