vim.g.omni_sql_no_default_maps = 1
vim.g.maplocalleader = ";"
require("me.lazy")
require("me.options")
require("me.lsp")
require("me.keymaps")
require("me.plugins")
require("me.colors")
require("me.autocmds")
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

-- from https://github.com/kovidgoyal/kitty/blob/master/docs/faq.rst#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
vim.cmd [[
" Mouse support
set mouse=a
" set ttymouse=sgr
" set balloonevalterm
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
" execute "set <FocusGained>=\<Esc>[I"
" execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"
" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''
]]
