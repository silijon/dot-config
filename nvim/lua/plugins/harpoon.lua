return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      -- basic telescope integration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers').new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = 'Add current buffer to Harpoon' })
      vim.keymap.set('n', '<leader>ht', function() toggle_telescope(harpoon:list()) end, { desc = 'Open Harpoon in telescope' })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Toggle Harpoon menu' })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = 'Select previous Harpoon buffer' })
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = 'Select next Harpoon buffer' })
      vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = 'Select Harpoon buffer 1' })
      vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = 'Select Harpoon buffer 2' })
      vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = 'Select Harpoon buffer 3' })
      vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = 'Select Harpoon buffer 4' })

    end,
  },
}
