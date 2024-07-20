local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local nvomap = function(...)
  map({ "n", "v", "o" }, ...)
end

local noremap = function(mode, lhs, rhs)
  local opts = {
    remap = false,
    silent = true,
  }

  map(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.g.vscode then
  -- toggle visibility of file tree
  nvomap("<C-t>", function()
    require("nvim-tree.api").tree.toggle()
  end)
end

-- exit to normal mode
map({ "i", "v", "o" }, "<C-c>", "<Esc>", { silent = true })

-- capitalize first letter of a word
nvomap("mkU", "viwo<Esc>gUl")
nvomap("mku", "viwo<Esc>gul")

-- better window navigation
nvomap("<C-h>", "<C-w>h", { silent = true })
nvomap("<C-l>", "<C-w>l", { silent = true })
nvomap("<C-j>", "<C-w>j", { silent = true })
nvomap("<C-k>", "<C-w>k", { silent = true })

-- better buffer navigation
nvomap("L", "<cmd>bnext<cr>", { silent = true })
nvomap("H", "<cmd>bprevious<cr>", { silent = true })

-- better tab navigation
noremap("n", "<Tab>", "<cmd>tabnext<cr>")
noremap("n", "<C-Tab>", "<cmd>tabprevious<cr>")

-- fuzzy finder mappings
local builtin = require("telescope.builtin")
noremap("n", "<Leader>ff", function()
  builtin.find_files()
end)
noremap("n", "<Leader>fg", builtin.live_grep)
noremap("n", "<Leader>fb", builtin.buffers)
noremap("n", "<Leader>fh", builtin.help_tags)
noremap("n", "<Leader>fc", builtin.commands)

-- escape the terminal without killing it
noremap("t", "<Esc>", "<C-\\><C-n>")

-- window resizing
noremap("n", "<Leader>+", "<cmd>resize +2<cr>")
noremap("n", "<Leader>-", "<cmd>resize -2<cr>")
noremap("n", "<Leader><Leader>+", "<cmd>vertical resize +2<cr>")
noremap("n", "<Leader><Leader>-", "<cmd>vertical resize -2<cr>")

noremap("n", "<leader>=", "<cmd>vertical resize 87<cr>")

-- session
noremap("n", "<leader>mks", "<cmd>mksession!<cr>")

-- moving around text like vscode
-- mac compatible
noremap("n", "º", "<cmd>m .+1<cr>==")
noremap("n", "∆", "<cmd>m .-2<cr>==")
--
noremap("i", "º", "<Esc><cmd>m .+1<cr>==gi")
noremap("i", "∆", "<Esc><cmd>m .-2<cr>==gi")
--
noremap("v", "º", "<cmd>m '>+1<cr>gv=gv")
noremap("v", "∆", "<cmd>m '<-2<cr>gv=gv")

-- todo: does not work for some reason
-- surround a word with \wip{} (a latex command i use a lot)
--noremap("n", "mkw" ,"ysiwfwip<CR>i\\<ESC>f(cs)}")
-- surround a selection with \wip{} (a latex command i use a lot)
--noremap("v", "mkw" ,"Sfwip<CR>i\\<ESC>f(cs)}")

---- only compatible with non-mac (or add 'macos_option_as_alt left' to kitty.conf)
--noremap("n", "<M-j>", "<cmd>m .+1<cr>==")
--noremap("n", "<M-k>", "<cmd>m .-2<cr>==")
----
--noremap("i", "<M-j>", "<Esc><cmd>m .+1<cr>==gi")
--noremap("i", "<M-k>", "<Esc><cmd>m .-2<cr>==gi")
----
--noremap("v", "<M-j>", "<cmd>m '>+1<cr>gv=gv")
--noremap("v", "<M-k>", "<cmd>m '<-2<cr>gv=gv")

-- invoke hop
nvomap("<Leader>7", function()
  require("hop").hint_patterns {}
end)

-- clean highlights
noremap({ "n", "v", "o" }, "<Leader>1", "<cmd>noh<cr>")

-- toggle file symbols
--map("n", "<F8>", function()
--  require(aerial").toggle {
--    focus = false,
--  }
--end)

local NS = { noremap = true, silent = true }

map("x", "aa", function()
  require("align").align_to_char { length = 1, preview = true}
end, NS) -- Aligns to 1 character, looking left

map("x", "as", function()
  require("align").align_to_char { length = 2, preview = true, regex = true}
end, NS) -- Aligns to 2 characters, looking left and with previews

map("x", "aw", function()
  require("align").align_to_string { preview = false, regex = true }
end, NS) -- Aligns to a string, looking left and with previews

noremap({"n", "v"}, "<Leader>.", vim.fn["pointfree#suggestions"])

-- snippets
-- Jump forward or backward
vim.cmd([[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]])
