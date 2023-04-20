return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  -- colorscheme = "kimbox",
  colorscheme = "kimbie",
  -- colorscheme = "everforest",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  plugins = {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { -- add a new dependency to telescope that is our new plugin
        "nvim-telescope/telescope-media-files.nvim",
      },
      -- the first parameter is the plugin specification
      -- the second is the table of options as set up in Lazy with the `opts` key
      config = function(plugin, opts)
        -- run the core AstroNvim configuration function with the options table
        require "plugins.configs.telescope" (plugin, opts)

        -- require telescope and load extensions as necessary
        local telescope = require "telescope"
        telescope.setup {
          extensions = {
            media_files = {
              -- filetypes whitelist
              -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
              filetypes = { "png", "webp", "jpg", "jpeg" },
              -- find command (defaults to `fd`)
              find_cmd = "rg",
            },
          },
        }
        telescope.load_extension "media_files"
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "RRethy/nvim-treesitter-endwise" },
      config = function(plugin, opts)
        require "plugins.configs.nvim-treesitter" (plugin, opts)
        require("nvim-treesitter-endwise").init()

        require("nvim-treesitter.configs").setup {
          endwise = {
            enable = true,
          },
        }
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      config = function(plugin, opts) require "plugins.configs.neo-tree" (plugin, opts) end,
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
  heirline = {
    colors = {
      bg = "#274952",
      winbar_bg = "#221a0f",
      winbarnc_bg = "#221a0f",
      tabline_bg = "#221a0f",
    },
  },
}
