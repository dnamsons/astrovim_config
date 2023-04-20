-- TODO: Potential plugins
-- https://github.com/ray-x/lsp_signature.nvim
--
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
  },
  { "lmburns/kimbox", opts = {}, event = "VeryLazy" },
  -- {
  --   "monsonjeremy/onedark.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("onedark").setup {
  --       colors = {
  --         bg = "#221a0f",
  --         fg = "#d3af86",
  --         fg_gutter = "#a57a4c",
  --         bg_visual = "#ff0000",
  --         blue = "#8ab1b0",
  --         green = "#889b4a",
  --         purple = "#98676a",
  --         red = "#dc3958",
  --         cyan = "#418292",
  --         orange = "#f06431",
  --       },
  --     }
  --   end,
  -- },
  {
    "monsonjeremy/onedark.nvim",
    dir = "~/Dev/kimbie.nvim",
    config = function() require("kimbie").setup() end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "nvim-treesitter/playground",
    event = "User AstroFile",
    config = function()
      require("nvim-treesitter.configs").setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    event = "VeryLazy",
  },
  -- "undotree",
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    opts = {},
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup {
        endwise = {
          enable = true,
        },
      }
    end,
    event = "User AstroFile",
  },
  -- "RRethy/nvim-treesitter-endwise",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
  },
  -- Took code from this and made my own version with Obsidian daily notes
  -- {
  --   "JellyApple102/flote.nvim",
  --   lazy = false,
  --   config = function()
  --     require("flote").setup {
  --       q_to_quit = true,
  --       window_style = "minimal",
  --       window_border = "solid",
  --       window_title = true,
  --     }
  --   end,
  -- },
}
