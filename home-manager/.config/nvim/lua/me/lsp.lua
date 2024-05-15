-- the by mason installed lsps
-- for lsps which are not installed by mason
-- see the 'not_by_mason' table and the function
-- 'setup_lsp'
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local lsps = {
  "pyright",
  "lua_ls",
  "jsonls",
  "yamlls",
  "texlab",
  "ltex", -- langaugetool
  "rust_analyzer",
  -- "jdtls", -- later
  "gradle_ls",
  -- always good to have
  "html",
  "cssls",
  "bashls",
  "clangd",
  "dockerls",
  "r_language_server",
  -- zettelkasten / markdown
  "marksman",
  -- nix
  "nil_ls", -- idk if it works or now
}

local set_lsps
do
  local set = {}
  for _, value in pairs(lsps) do
    set[value] = true
  end
  set_lsps = vim.deepcopy(set)
end

require("mason").setup {
  ui = {
    border = "single",
    width = 0.8,
    height = 0.8,
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
}

require("mason-lspconfig").setup {
  ensure_installed = {}, --, vim.deepcopy(lsps),
  automatic_installation = false,
  -- {
  -- exclude = {
  --   "julials",
  --   "hls",
  --   "ocamllsp",
  --    -- managd by nix
  --   "gopls",
  --   "gleam",
  --   "erlangls",
  --   "solargraph",
  --   "fsautocomplete",
  -- },
  -- },
}

vim.diagnostic.config {
  virtual_text = true,
  float = {
    border = "single",
  },
  severity_sort = true,
  underline = true,
  update_on_insert = true,
}

-- for old deleted options: 9fc462172338de76d54ad9491a9025acd1a950a9
local on_attach = function(server, bufnr)
  local lsp_semantic_tokens = server.server_capabilities.semanticTokensProvider
  local filetype = vim.bo.filetype
  if vim.version().minor >= 9 and lsp_semantic_tokens and filetype == "java" then
    server.server_capabilities.semanticTokensProvider = vim.NIL
  end
  -- Mappings. for other mappings see: ~/.config/nvim/mycoc/nativelspsaga.vim
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local map = vim.keymap.set
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "<Leader>cl", vim.lsp.codelens.run, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
  map("n", "gr", vim.lsp.buf.references, bufopts)
  if filetype ~= "crystal" then
    map("n", "<Leader>q", vim.lsp.buf.format, bufopts)
  end

  local codeLensCallback = function()
    local filetype2 = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype2 == "ocaml" then
      require("me.codelens").refresh_virtlines()
    elseif filetype2 ~= "java" then
      vim.lsp.codelens.refresh()
    end
  end

  if server.server_capabilities.codeLensProvider then
    local autocmds = require("me.autocmds")
    local group = autocmds.group("CodeLensRefresh")
    autocmds.cmd({
      "BufEnter",
      "CursorHold",
      "InsertLeave",
    })({
          group = group,
          callback = codeLensCallback,
          buffer = bufnr,
        })
    autocmds.cmd("BufEnter") {
      group = group,
      callback = codeLensCallback,
      buffer = bufnr,
    }
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers {
  function(name)
    lspconfig[name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,

  ["rust_analyzer"] = function()
    require("rust-tools").setup {
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
    }
  end,

  ["ltex"] = function()
    local path = vim.fn.stdpath("config") .. "/spell/de.utf-8.add"

    local cm = require("plenary").context_manager
    local words = {}
    cm.with(cm.open(path, "r"), function(reader)
      for word in reader:lines() do
        table.insert(words, word)
      end
    end)

    lspconfig["ltex"].setup {
      autostart = false,
      settings = {
        ltex = {
          trace = { server = "verbose" },
          language = "de-DE",
          enabled = { "bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext",
            "rsweave", "haskell", "python", "java" },                               -- idk if this works either
          dictionary = { ["de-DE"] = words, ["en-GB"] = words, ["zh-CE"] = words }, -- this doesn't seem to work?
          additionalRules = {
            motherTongue = "de-DE",
          },
        }
      }
    }
  end,

  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup {
      on_attach = on_attach,
      capabilties = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          telemetry = false,
          diagnostics = {
            globals = { "vim" },
          },
        }
      }
    }
  end,

  ["jdtls"] = function()
    lspconfig["jdtls"].setup {
      on_attach = on_attach,
      capabilties = capabilities,
      cmd = { "jdt-language-server" },
    }
  end

}

local not_by_mason = {
  ["gopls"] = true,
  ["hls"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
    settings = {
      haskell = {
        formattingProvider = "stylish-haskell",
        -- formattingProvider = "fourmolu",
        cabalFormattingProvider = "cabalfmt",
        plugin = {
          tactics = { -- wingman
            globalOn = true,
            codeLensOn = true,
          },
        },
      },
    },
  },
  ["ocamllsp"] = true,
  ["gleam"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    filetypes = { "gleam" },
    cmd = { "gleam", "lsp" },
    settings = {
      gleam = {
      },
    },
  },
  ["erlangls"] = true, -- for gleam interop
  ["solargraph"] = true,
  ["tsserver"] = true,
  ["racket_langserver"] = true,
  ["crystalline"] = true,
  ["serve_d"] = true,
  ["sourcekit"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    filetypes = { "swift" },
    cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
  },
  ["sqls"] = true,
  ["jdtls"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    -- needs fixing
    cmd = { "jdt-language-server", "-data", vim.fn.expand("~") .. "/.local/share/jdtls/" .. vim.fn["getcwd"]() },
  },
  -- nextserver
}

-- lspconfig["racket_langserver"].setup {
--   on_attach = on_attach,
--   capabilties = capabilities,
--   -- cmd = { "racket", "--lib", "racket-langserver", "--", "--stdio" },
--   -- filetypes = { "racket" },
--   -- settings = {
--   --   racket = {
--   --     -- racket-langserver settings
--   --   },
--   -- },
-- }

-- setsup lsps which installations are not handled with
-- mason
local function setup_lsp(l_lsps)
  local mason = require("lspconfig")
  for server, config in pairs(l_lsps) do
    if set_lsps[server] then
      vim.print(server .. " already exists and is setup by mason!")
      goto continue
    end

    if type(config) == "table" then
      mason[server].setup(config)
    elseif type(config) == "boolean" then
      mason[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
    ::continue::
  end
end

setup_lsp(not_by_mason)

return {
  on_attach = on_attach,
  capabilities = capabilities,
}
