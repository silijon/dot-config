return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      ignore_errors = false
    },
    config = function()
      local lint = require("lint")

      --------------------------------------------------------------------
      -- 1. Configure linters per filetype
      --------------------------------------------------------------------
      lint.linters_by_ft = {
        text     = { "cspell" },
        markdown = { "markdownlint", "cspell" },
        python   = { "pylint" },
      }

      --------------------------------------------------------------------
      -- 2. Derive one unique set of *all* linter names
      --------------------------------------------------------------------
      local linter_set = {}      --  lookup  linter_set[name] → true
      for _, linters in pairs(lint.linters_by_ft) do
        for _, name in ipairs(linters) do
          linter_set[name] = true
        end
      end
      -- If you ever need the list as an array:
      -- local linter_list = vim.tbl_keys(linter_set)

      --------------------------------------------------------------------
      -- 3. Toggle: show linters (run) ⇄ hide them (reset only those active)
      --------------------------------------------------------------------
      local visible = true   -- start with diagnostics shown

      local function toggle_linter_diagnostics(bufnr)
        bufnr = bufnr or 0      -- 0 ⇒ current buffer

        visible = not visible
        if visible then
          -- Re-run the linters for the current buffer
          lint.try_lint()
          return
        end

        ------------------------------------------------------------------
        -- Hide phase:
        -- * enumerate all current namespaces (`vim.diagnostic.get_namespaces`)
        -- * if its *name* is one of our linters *and* the buffer actually
        --   has diagnostics in that namespace, reset it for this buffer
        ------------------------------------------------------------------
        local nsinfo = vim.diagnostic.get_namespaces()  -- {ns_id → {name=…}}
        for ns_id, info in pairs(nsinfo) do
          if linter_set[info.name] then
            if #vim.diagnostic.get(bufnr, { namespace = ns_id }) > 0 then
              vim.diagnostic.hide(ns_id, bufnr)
            end
          end
        end
      end

      -- Run after save, insert leave, etc.
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        callback = function()
          print(visible)
          if visible then
            lint.try_lint()
          end
        end
      })

      -- Set python linters to work in virtualenv
      local venv = os.getenv('VIRTUAL_ENV') or '/usr'
      lint.linters.pylint.cmd = venv .. "/bin/python"
      lint.linters.pylint.args = { "-m", "pylint", "-f", "json", "--from-stdin", function() return vim.api.nvim_buf_get_name(0) end, }

      -- Disable annoying overly pedantic rules
      lint.linters.markdownlint.args = { "--stdin", "--disable", "MD013", "--", }

      vim.keymap.set("n", "<leader>fl", toggle_linter_diagnostics, { desc = "[L]int Current Buffer" })
      vim.keymap.set("n", "<leader>fs", function() lint.try_lint("cspell") end, { desc = "[S]pellcheck Current Buffer" })

    end
  }
}
