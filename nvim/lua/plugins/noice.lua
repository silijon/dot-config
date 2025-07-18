return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("notify").setup({
        background_colour = "#000000"
      })

      require("noice").setup({
        views = {
          cmdline_popup = {
            position = {
              row = 10,
            }
          },
        },
        routes = {
          -- filter nagging deprecation messages
          {
            filter = {
              find = "deprecated",
            },
            opts = { skip = true },
          },
          -- filter yank,paste,cut
          {
            filter = {
              event = "msg_show",
              find = "lines yanked",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              find = "more lines",
            },
          },
          {
            filter = {
              event = "msg_show",
              find = "fewer lines",
            },
          },
          {
            filter = {
              event = "msg_show",
              find = "clipboard: No provider.",
            },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })

      -- Listen for the custom escape event (do this instead of mapping <Esc> to avoid conflicts)
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.api.nvim_create_autocmd("User", {
        pattern = "EscapePressed",
        callback = require("notify").dismiss,
        desc = "Dismiss noice messages on escape",
      })

    end,
  },
}
