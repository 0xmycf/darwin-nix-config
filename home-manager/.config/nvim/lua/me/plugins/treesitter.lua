require("nvim-treesitter.configs").setup {
  auto_install = false,
  ensure_installed = false,
  sync_install = false,
  ignore_install = { "latex", "bibtex" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false, -- breaks for example ruby
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "gnn", -- set to `false` to disable one of the mappings
      node_incremental  = "grn",
      scope_incremental = "grc",
      node_decremental  = "grm",
    },
  },
}
