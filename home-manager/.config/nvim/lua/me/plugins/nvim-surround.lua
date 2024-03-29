require("nvim-surround").setup {
  keymaps = { -- vim-surround style keymaps
    normal = "ys",
    normal_line = "yss",
    visual = "S",
    delete = "ds",
    change = "cs",
  },
  highlight = { -- Highlight before inserting/changing surrounds
    duration = 0,
  },
}
