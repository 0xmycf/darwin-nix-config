require("me.lazy")
require("me.options")
require("me.lsp")
require("me.autocmds")
require("me.keymaps")
require("me.colors")
require("me.plugins")
require("me.plugins.harpoon")

-- this is used in 2 places:
--  1. here
--  2. in lazy.lua for initializing local plugins
require("me.private.private") -- mine muhahahaha

vim.o.spell = false

-- todo outsource this
-- tex stuff
vim.cmd("map mkw ysiw}i\\wip<ESC>f}")
vim.cmd("vmap mkw S}i\\wip<ESC>f}")
-- tex stuff but less specific
--  e for environment
vim.cmd("map mke ysiw}i\\<ESC>a")
vim.cmd("vmap mke S}i\\<ESC>a")

vim.cmd("map <leader>cn :cn<CR>")
vim.cmd("map <leader>cp :cp<CR>")

if vim.g.vscode then
else
  vim.cmd [[
  let g:omni_sql_no_default_maps = 1
  let g:ftplugin_sql_omni_key = '<leader>sql'
  ]]
  vim.g.omni_sql_no_default_maps = 1
  vim.g.ftplugin_sql_omni_key = '<leader>sql'
end
