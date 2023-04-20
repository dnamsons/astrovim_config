-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    --
    ["<leader>U"] = {
      vim.cmd.UndotreeToggle,
      desc = "Undotree",
    },
    -- FIXME: Doesn't work right now, would be cool if worked. <A-j> seems better than <C-j>
    -- ["<A-j>"] = {
    --   "<cmd>MoveLine(1)<cr>",
    --   desc = "Move line down",
    -- },
    -- ["<A-k>"] = {
    --   "<cmd>MoveLine(-1)<cr>",
    --   desc = "Move line up",
    -- },
    --
    -- TODO: There is an alternative without needing a plugin
    -- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
    -- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
    -- from https://www.chiarulli.me/Neovim-2/02-keymaps/
    ["<A-j>"] = {
      -- "<C-U><cmd>MoveLine(1)<cr>",
      -- ':<C-U> exe "MoveLine ".v:count1<cr>',
      ':<C-U> exe "m +".v:count1<cr>',
      desc = "Move line down",
    },
    ["<A-k>"] = {
      -- "<C-U><cmd>MoveLine(-1)<cr>",
      -- ':<C-U> exe "MoveLine -".v:count1<cr>',
      ':<C-U> exe "m -".(v:count1+1)<cr>',
      desc = "Move line up",
    },
    ["<leader>fN"] = {
      ":Telescope find_files search_dirs=~/Documents/TradeLink <cr>",
      desc = "Obsidian notes",
    },
    ["<leader>N"] = {
      function()
        local file = os.date "%Y-%m-%d.md"
        local file_path = "~/Documents/TradeLink/Daily" .. "/" .. file

        if vim.tbl_isempty(vim.fs.find(file, { type = "file", path = file_path })) then
          os.execute("touch " .. file_path)
        end

        local ui = vim.api.nvim_list_uis()[1]
        local width = math.floor((ui.width * 0.5) + 0.5)
        local height = math.floor((ui.height * 0.5) + 0.5)

        local note_buf = vim.api.nvim_create_buf(false, true)

        local win_opts = {
          relative = "editor",
          width = width,
          height = height,
          col = (ui.width - width) / 2,
          row = (ui.height - height) / 2,
          focusable = false,
          style = "minimal",
          border = "solid",
        }

        win_opts.title = os.date "%d.%m.%Y"
        win_opts.title = win_opts.title .. " - press 'q' to quit"
        win_opts.title_pos = "left"

        vim.api.nvim_open_win(note_buf, true, win_opts)

        vim.cmd("edit " .. file_path)

        vim.api.nvim_buf_set_option(note_buf, "bufhidden", "wipe")
        vim.api.nvim_buf_set_keymap(note_buf, "n", "q", "<cmd>wq<CR>", { noremap = true, silent = false })
      end,
      desc = "Open today's Obsidian note",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  -- TODO: Add mappings for text movements up & down
  v = {
    ["<leader>re"] = {
      "<cmd>lua require('refactoring').refactor('Extract Function')<cr>",
      desc = "Extract Function",
    },
  },
  x = {},
}
