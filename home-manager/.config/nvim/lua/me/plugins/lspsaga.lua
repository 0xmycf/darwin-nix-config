local keymap = vim.keymap.set
local saga = require("lspsaga")

-- use default config but remove the annoying lightbulb
saga.setup {
  lightbulb = { enable = false }
}

-- code action
vim.keymap.set("n", "<leader>ac", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("v", "<leader>ac", "<cmd>Lspsaga range_code_action<CR>", { silent = true, noremap = true })

-- show hover doc and press twice will jumpto hover window
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- rename
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "<leader>hg", "<cmd>Lspsaga peek_definition<CR>")

keymap("n", "E", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- jump diagnostic
keymap("n", "<leader><F3>", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "<F3>", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
keymap("n", "<leader><F2>", function()
  require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
end)
keymap("n", "<F2>", function()
  require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
end)
-- or use command
--vim.keymap.set("n", "<F10>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
--vim.keymap.set("t", "<F10>", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", { silent = true })

-- Float terminal
keymap({ "n", "t" }, "<F10>", "<cmd>Lspsaga term_toggle<CR>")
