-- load plugins
require("me.plugins.gitsigns")
require("me.plugins.nvim-surround")

local ok, reason = pcall(require, "me.plugins.treesitter")
if not ok then
  print("treesitter not working: ", reason)
end

-- moved to autocmds
-- require("me.plugins.lualine")
require("me.plugins.comment")
require("me.plugins.cmp")
