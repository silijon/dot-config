return {
  {
    "voldikss/vim-floaterm",
    event = "VeryLazy",
    config = function()
      vim.g.floaterm_width = 0.85
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
      local term_name = "master"

      -- check if terminal exists
      local function master_term_exists()
        local bufnr = vim.fn["floaterm#terminal#get_bufnr"](term_name)
        return bufnr > 0 and vim.api.nvim_buf_is_valid(bufnr)
      end


      -- trims all whitespace from the first line
      -- then only from subsequent lines relative to the first
      -- this leaves relative indentation in-tact
      local function trim_relative(lines)
        local indent_count

        -- helper: strip up to indent_count leading whitespace
        local function strip_indent(line, indent)
          local i = 1
          local len = #line
          while i <= indent and i <= len and line:sub(i, i):match("%s") do
            i = i + 1
          end
          return line:sub(i)
        end

        for idx, raw in ipairs(lines) do
          -- only trim the front
          local line = raw

          if idx == 1 then
            -- remove all leading whitespace on first line...
            local trimmed = line:match("^%s*(.*)$")
            -- record how many chars we removed
            indent_count = #line - #trimmed
            lines[idx] = trimmed
          else
            -- ...then for each other line, strip up to indent_count
            if indent_count and indent_count > 0 then
              lines[idx] = strip_indent(line, indent_count)
            end
          end
        end
      end


      -- [[ Keybindings ]]
      -- Toggle a persistent terminal from normal mode
      vim.keymap.set("n", "t", function()
        vim.cmd("FloatermToggle " .. term_name)
      end, { desc = "Toggle Floaterm" })


      -- Toggle a persistent terminal from visual mode
      -- Here the visual selection is sent to the terminal
      vim.keymap.set("v", "t", function()

        -- yank visual selection to register z and clean it up
        vim.cmd('normal! "zy')
        local raw = tostring(vim.fn.getreg('z'))
        local lines = vim.tbl_filter(function(line)
            return line:match("%S")  -- keep only lines that contain non-whitespace
        end, vim.fn.split(raw, "\n"))
        trim_relative(lines)

        -- decide show vs new
        if master_term_exists() then
          -- if it already exists we can send the selection and show immediately
          -- order is important since we can't send when the terminal window is active
          local bufnr = vim.fn["floaterm#terminal#get_bufnr"](term_name)
          vim.fn["floaterm#terminal#send"](bufnr, lines)
          vim.cmd("FloatermShow " .. term_name)
        else
          -- if no existing buffer with our name, create a new one
          -- this must be "silent" since we can't send when the terminal window is openb
          vim.cmd("FloatermNew --silent --name=" .. term_name)
          -- wait a sec for it to spin up (avoids echo'ing before prompt)
          vim.defer_fn(function()
            local bufnr = vim.fn["floaterm#terminal#get_bufnr"](term_name)
            vim.fn["floaterm#terminal#send"](bufnr, lines)
            vim.cmd("FloatermShow " .. term_name)
          end, 1200)
        end
      end, { desc = "Send visual selection to named Floaterm" })


      -- remap exit terminal mode to sane
      vim.keymap.set({ "t", "n" }, "<C-q>", "<C-\\><C-n>:FloatermHide<CR>", {
        desc = "Hide Floaterm",
        noremap = true,
        silent = true,
      })


      -- remap entering normal mode inside the terminal window to sane
      vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", {
        desc = "Enter normal mode in terminal",
        noremap = true,
      })
    end
  },
}
