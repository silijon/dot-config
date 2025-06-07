return {
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_borderchars = '─│─│╭╮╯╰'

      -- Keymaps to toggle a peristent terminal
      vim.keymap.set({ "n" }, "<leader>t", function()
        vim.cmd("FloatermToggle")
      end, { desc = "Toggle Floaterm" })

      vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:FloatermHide<CR>", {
        desc = "Hide Floaterm",
        noremap = true,
        silent = true,
      })

      vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", {
        desc = "Enter normal mode in terminal",
        noremap = true,
      })

      -- Set Floaterm and FloatermBorder background to transparent
      vim.api.nvim_set_hl(0, "Floaterm",       { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "NONE" })

    end
  },
}
