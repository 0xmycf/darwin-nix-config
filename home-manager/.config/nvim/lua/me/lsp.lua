local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure rustaceanvim before it loads
vim.g.rustaceanvim = {
  server = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--", "-A", "clippy::pedantic" },
        }
      }
    }
  },
}


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
  -- ["erlangls"] = true, -- for gleam interop
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
    capabilities = capabilities,
    filetypes = { "haskell", "lhaskell", "cabal" },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      haskell = {
        formattingProvider = "fourmolu", -- better divs, and just overall more unified styling applied
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
    capabilties = capabilities,
    filetypes = { "gleam" },
    cmd = { "gleam", "lsp" },
    settings = {
      gleam = {
      },
    },
  },

  ["sourcekit"] = {
    capabilties = capabilities,
    filetypes = { "swift" },
    cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
  },

  ["jdtls"] = {
    capabilties = capabilities,
    cmd = { "jdtls", "-data", vim.fn.expand("~") .. "/.local/share/jdtls/" .. vim.fn["getcwd"]() },
  },

  -- c#
  ["omnisharp"] = {
    cmd = {
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

local defaults = {
  capabilities = capabilities,
  root_dir = function(_, on_dir) on_dir(vim.fn.getcwd()) end -- this was very important for some lsps to start, not sure why
}

for lsp_name, config in pairs(lsps) do
  if config == true then
    vim.lsp.config(lsp_name, defaults)
  elseif type(config) == "function" then
    config()
  elseif config ~= false then
    local with_defaults = vim.tbl_deep_extend("force", {}, defaults, config)
    vim.lsp.config(lsp_name, with_defaults)
  end
end

do
  local lsp_names = {}
  for lsp_name, _ in pairs(lsps) do
    lsp_names[#lsp_names + 1] = lsp_name
  end
  vim.lsp.enable(lsp_names) -- some still dont start up, but most do now
end

return {
  capabilities = capabilities,
}
