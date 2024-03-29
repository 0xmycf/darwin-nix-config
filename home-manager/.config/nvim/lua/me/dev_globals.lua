-- Yes I got this from tj

function P(something)
  vim.print(vim.inspect(something))
end

vim.keymap.set({ 'n' }, "<leader><leader>x", function()
  vim.cmd("w")
  vim.cmd("source %")
end)

-- -- path must be string
-- -- does not check if path already exists and will overwrite it if it does!
-- function Write_tmp(text, path)
--   path = path or "/tmp/foobar.txt"
--   local cm = require("plenary").context_manager
--   local p = require("plenary.path")
--   cm.with(cm.open(p:new(path), "w"), function(writer)
--     writer:write(vim.inspect(text))
--   end)
-- end

-- function Get_cl()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local params = { textDocument = vim.lsp.util.make_text_document_params() }
--   vim.lsp.buf_request(bufnr, "textDocument/codeLens", params, function(err, result, _, _)
--     if err then
--       return
--     end
--     local cm = require("plenary").context_manager
--     local p = require("plenary.path")
--     cm.with(cm.open(p:new("/tmp/foobar.txt"), "w"), function(writer)
--       writer:write(vim.inspect(result))
--     end)
--   end)
-- end
