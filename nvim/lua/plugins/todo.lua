return {
    { -- Handles todo.txt file
      "freitass/todo.txt-vim",
      config = function()

        -- [[ Make todo.txt appear in a float ]]
        -- Copy Normal’s background into NormalFloat (once + on theme-swap)
        local function align_float_bg()
          local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal_bg })
        end

        -- run now …
        align_float_bg()
        -- … and every time you :colorscheme something
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = align_float_bg,
        })

        local todo = {}
        local path = vim.fn.expand("~/Dropbox/Documents/todo.txt")

        todo.buf  = nil   -- buffer handle
        todo.win  = nil   -- window handle

        ---@return boolean visible  True if the floating todo window is up
        local function is_open()
          return todo.win and vim.api.nvim_win_is_valid(todo.win)
        end

        local function open_float()
          -- load / create buffer ------------------------------------------
          if todo.buf and vim.api.nvim_buf_is_valid(todo.buf) then
            -- buffer already exists
          elseif vim.fn.filereadable(path) == 1 then
            todo.buf = vim.fn.bufadd(path)
            vim.fn.bufload(todo.buf)
          else
            vim.notify("❌ Not Found: " .. path, vim.log.levels.ERROR)
            return
          end

          -- window geometry -----------------------------------------------
          local ui      = vim.api.nvim_list_uis()[1]
          local width   = math.floor(ui.width  * 0.7)
          local height  = math.floor(ui.height * 0.7)
          local row     = math.floor((ui.height - height) / 2)
          local col     = math.floor((ui.width  - width)  / 2)

          todo.win = vim.api.nvim_open_win(todo.buf, true, {
            relative = "editor",
            row = row,
            col = col,
            width = width,
            height = height,
            style = "minimal",
            noautocmd = true,
            title = " John's TODO List ",
            title_pos  = "center",            -- "left" | "center" | "right"
            border = "rounded",
          })

          -- optional window-local opts
          -- window-local
          vim.wo[todo.win].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"
          vim.wo[todo.win].wrap = false
          vim.wo[todo.win].signcolumn = "yes"
          vim.wo[todo.win].number = false

          -- buffer-local
          vim.bo[todo.buf].bufhidden = "wipe"   -- buffer options live in vim.bo
        end


        -- Setup key-binding as a toggle
        local function close_float()
          if is_open() then
            vim.api.nvim_win_close(todo.win, true)
          end
          if todo.buf and vim.api.nvim_buf_is_loaded(todo.buf) then
            vim.api.nvim_buf_delete(todo.buf, { force = true })
          end
          todo.buf, todo.win = nil, nil
        end

        function todo.toggle()
          if is_open() then
            close_float()
          else
            open_float()
          end
        end

        -- Key-binding: <leader>t
        vim.keymap.set("n", "<leader>t", todo.toggle,
          { desc = "Toggle floating todo.txt", silent = true, noremap = true })


        -- Shut off folding
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "todo" },   -- adjust to your actual &filetype
          callback = function()
            vim.opt_local.foldenable = false
            vim.opt_local.foldmethod = "manual"
          end,
        })


        -- Define (or re-define) TodoDone to look like Comment + strike-through
        local function set_todo_done_hl()
          -- `link=false` gives you the *resolved* colours of Comment
          local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
          vim.api.nvim_set_hl(0, "TodoDone", {
            fg            = comment.fg or comment.foreground,    -- keep same colour
            ctermfg       = comment.ctermfg,                     -- terminal palette
            strikethrough = true,                                -- the extra bit
          })
        end

        -- run it right now (for the current session)
        set_todo_done_hl()

        -- Run it again whenever the filetype plugs in or the theme changes
        vim.api.nvim_create_autocmd("FileType", {
          pattern  = { "todo", "todotxt" },     -- adjust to your actual &filetype
          callback = set_todo_done_hl,
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = set_todo_done_hl,
        })

      end
  },
}
