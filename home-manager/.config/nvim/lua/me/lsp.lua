local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

local lsps = {
  ["jsonls"] = true,
  ["yamlls"] = true,
  ["texlab"] = true,
  ["gradle_ls"] = true,
  ["html"] = true,
  ["cssls"] = true,
  ["bashls"] = true,
  ["clangd"] = true,
  ["dockerls"] = true,
  ["nil_ls"] = true,
  ["erlangls"] = true, -- for gleam interop
  ["solargraph"] = true,
  ["ocamllsp"] = true,
  ["ts_ls"] = true,
  ["racket_langserver"] = true,
  ["crystalline"] = true,
  ["serve_d"] = true,
  ["sqls"] = true,
  ["fsautocomplete"] = true,
  ["janet_lsp"] = true,
  ["graphql"] = true,
  ["r_language_server"] = false,
  ["fish_lsp"] = true,
  ["dartls"] = true,
  ["clojure_lsp"] = true,
  ["angularls"] = true,
  ["zls"] = true,
  ["roc_ls"] = true,
  ["basedpyright"] = true,
  ["gopls"] = true,

  ["hls"] = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
    flags = {
      debounce_text_changes = 150,
    },
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
  ["sourcekit"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    filetypes = { "swift" },
    cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
  },
  ["jdtls"] = {
    on_attach = on_attach,
    capabilties = capabilities,
    cmd = { "jdtls", "-data", vim.fn.expand("~") .. "/.local/share/jdtls/" .. vim.fn["getcwd"]() },
  },
  -- c#
  ["omnisharp"] = {
    cmd = {
      on_attach = on_attach,
      capabilties = capabilities,
      vim.fn.executable('OmniSharp') == 1 and 'OmniSharp' or 'omnisharp',
      '-z', -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
      '--hostPID',
      tostring(vim.fn.getpid()),
      'DotNet:enablePackageRestore=false',
      '--encoding',
      'utf-8',
      '--languageserver',
    },
  },
  ["lua_ls"] = {
      on_attach = on_attach,
      capabilties = capabilities,
      single_file_support = true,
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

-- Configure rustaceanvim before it loads
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
}

for lsp, config in pairs(lsps) do
  if config == true then
    vim.lsp.config(lsp, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
    vim.lsp.enable(lsp)
  elseif type(config) == "function" then
    config()
  elseif config ~= false then
    vim.lsp.config(lsp, config)
    vim.lsp.enable(lsp)
  end
end


return {
  on_attach = on_attach,
  capabilities = capabilities,
}
