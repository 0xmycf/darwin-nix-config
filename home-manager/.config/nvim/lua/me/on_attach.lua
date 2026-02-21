
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

return on_attach
