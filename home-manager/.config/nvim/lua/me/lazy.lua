-- download lazy.nvim if it's not already available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local fn_dev_repos = require("me.private.private").local_plugins

local lazy_opts = {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",   -- lockfile generated after running update.
  install = {
    -- colorscheme = { "onedark" },
    colorscheme = { "catppuccin-latte" },
  },
  ui = {
    border = "rounded",
    size = { height = 0.8, width = 0.8 },
  },
  dev = {
    path = fn_dev_repos,
  },
}

local gh_copilot
do
  local do_vim = false   -- change this whenever you want to switch to lua
  gh_copilot = { vim = do_vim, lua = not do_vim }
end

require("lazy").setup({

  {
    "epwalsh/obsidian.nvim",
    version = "*",     -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = require("me.private.private").obsidian,
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = require("me.private.private").obsidian_path,
        },
      },
      attachments = {
        img_folder = "attachments/kasten",
      },
      templates = {
        subdir = "attachments/templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "100 Zettelkasten/000 Timed/",
        template = "attachments/templates/Daily Notes Template.md"
      },
      notes_subdir = "100 Zettelkasten",
      disable_frontmatter = true,
      note_id_func = function(title)
        return title
      end,
    },
  },

  {
    "LnL7/vim-nix",
    ft = "nix",

  },

  -- gleam programming language
  {
    "gleam-lang/gleam.vim",
    ft = "gleam",
  },

  {
    "mfussenegger/nvim-lint",
    ft = { "tcl" },
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'vale', }
      }
    end,
  },

  {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      cond = gh_copilot.lua,
      event = "InsertEnter",
      config = function()
          require("copilot").setup({
              suggestion = {
                  auto_trigger = true, -- def = false
                  keymap = {
                      accept = "<C-CR>",
                      next = "ø", -- <M-o>
                      prev = "⁄", -- <M-i>
                      dismiss = "±", -- <M-+>
                  }
              },
              panel = { enabled = false },
              filetypes = {
                  latex    = false,
                  tex      = false, -- I never know which is which
                  markdown = false,
                  java     = false,
                  rmd      = false,
              },
          })
      end,
      -- autostart = false;
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local highlight = {
        "RainbowBlue",
      }
      local highlightAll = {
        "GreyMycf",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        -- 81 88 100
        vim.api.nvim_set_hl(0, "GreyMycf", { fg = "#E06C75" })
      end)

      require("ibl").setup({
        exclude = {
          filetypes = { "text", "txt", "undotree", "latex", "md", "rmd", "bibtex", "tex" },
        },
        indent = {
          -- char = { "┋" },
          char = "",           -- turn off for now
          highlight = highlightAll,
        },
        scope = {         -- doesn't work?
          enabled = false,
          highlight = highlight,
        },
      })
    end
  },

  -- general required dependency adding icons
  "nvim-tree/nvim-web-devicons",

  -- git hunks on sign column
  "lewis6991/gitsigns.nvim",

  "kylechui/nvim-surround",

  -- git integration
  "tpope/vim-fugitive",
  "mg979/vim-visual-multi",

  {
    "dag/vim-fish",
    ft = "fish",
  },
  {
    "lervag/vimtex",
    ft = { "latex", "bibtex", "tex" }
  },

  "ThePrimeagen/harpoon",

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("me.plugins.nvim-tree")
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  -- Beautify LSP
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("me.plugins.lspsaga")
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "kdheepak/cmp-latex-symbols",
    },
  },

  -- snippet engine
  "hrsh7th/vim-vsnip",
  "hrsh7th/vim-vsnip-integ",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dev = true,
  },
  {
    "nvim-treesitter/playground",
    lazy = true,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  -- colorschemes / themes
  "0xmycf/Spacegray.vim",
  -- "joshdick/onedark.vim",
  "navarasu/onedark.nvim",   -- lua
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "latte"
      }
    end,
  },
  "rmehri01/onenord.nvim",
  -- "kamwitsta/flatwhite-vim",
  -- "ellisonleao/gruvbox.nvim",

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-web-devicons" }
  },

  -- auto-close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("me.plugins.nvim-autopairs")
    end,
  },

  -- replacement for aerial
  {
    "hedyhli/outline.nvim",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<F8>", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        outline_window = {
          auto_jump = true,
        },
      }
    end,
  },

  "Vonr/align.nvim",

  "numToStr/Comment.nvim",

  {
    "phaazon/hop.nvim",
    config = function()
      require("me.plugins.hop")
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },

  {
    "m00qek/vim-pointfree",
    config = function()
      -- this doesnt load
      vim.keymap.set({ "n", "v" }, "<Leader>.", vim.fn["pointfree#suggestions"], {
        silent = true,
        remap = false,
      })
    end,
    -- ft = "haskell",
  },

  -- scala
  -- {
  --   "scalameta/nvim-metals",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   ft = { "scala", "sbt", "java" },
  --   opts = function()
  --     local metals_config = require("metals").bare_config()
  --     metals_config.on_attach = function(client, bufnr)
  --       require("me.lsp").on_attach(client, bufnr)
  --       -- your on_attach function
  --     end
  --
  --     return metals_config
  --   end,
  --   config = function(self, metals_config)
  --     local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = self.ft,
  --       callback = function()
  --         require("metals").initialize_or_attach(metals_config)
  --       end,
  --       group = nvim_metals_group,
  --     })
  --   end
  -- }

}, lazy_opts)
