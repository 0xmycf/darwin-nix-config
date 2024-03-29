local opts = {
  -- accepted file encodings
  fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936",
  -- encoding used by neovim itself
  encoding = "utf-8",
  -- be iMproved (basically remove backwards support with vi)
  compatible = false,
  -- add a colored column after 83 chars (doesnt work mh)
  colorcolumn = 83,
  -- font used by neovide or other graphical UI
  guifont = "CaskaydiaCove Nerd Font Mono:15",
  -- guifont = "BQN386 Unicode:18", -- Set this font for use with neovide
  -- well if you wanna use any modern theme, this is a must
  termguicolors = true,
  -- don't wrap text at the end of lines
  wrap = false,
  --[[
    Maximum width of text that is being inserted.  A longer line will be
    broken after white space to get this width.  A zero value disables
    this. - copied straight from docs lmao
    ]]
  --
  textwidth = 0,
  -- make tabbing and indentation use four spaces always.
  -- Also remove tabs and switch them to spaces
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  smarttab = true,
  expandtab = true,
  smartindent = true,
  -- spell checker settings
  spelllang = "de_de,en_gb,cjk",
  spell = true,
  -- highlight current line
  cursorline = true,
  -- show lines numbers
  number = true,
  -- make line numbers relative to current line
  relativenumber = true,
  -- allow signs on the left, but only up to 1 of them
  signcolumn = "yes:1",
  -- disable swap
  -- (I do this too but I also prefer using undo files. Hit me up if you want me to tell you how to do that)
  swapfile = false,
  -- disable the mouse (I don't know why you weren't doing this)
  mouse = "",
  -- make the UI a bit more responsive
  updatetime = 200,
  -- scroll down 0 items earlier (change this so the cursor stays in the middle when scrolling up)
  scrolloff = 16,
  -- scroll to the side 8 items earlier
  sidescrolloff = 8,
  foldmethod = "marker", -- markers are cool, give them a try with {\{{(just remove the \) and 'za'
  -- uses block cursor, just remove this if you don't like it
  -- guicursor = "",
  -- disable messages for the current mode since our line will have them either way
  showmode = false,
  -- always show tabs
  showtabline = 2,

  conceallevel = 1,
}

vim.cmd([[
language en_US
filetype off
syntax enable
hi ColorColumn ctermbg=0 guibg=#464558
]])

-- initialize the settings using the values from above
for key, value in pairs(opts) do
  vim.o[key] = value
end

vim.g.python3_host_prog = "/usr/local/bin/python3.10"
vim.g.omni_sql_no_default_maps = 1
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_length = 0

if vim.fn.executable('rg') then
  vim.o.grepprg = "rg --vimgrep --hidden -g '!.git'"
end
