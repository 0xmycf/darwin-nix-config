local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    -- the keybinds only exist for this buffer!
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local map = vim.keymap.set

  map("n", "o", api.node.open.edit, opts("Open"))
  map("n", "<CR>", api.node.open.edit, opts("Open"))
  -- map("n", "<CR>", api.node.open.edit, opts("Open"))
  map("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  map("n", "H", api.node.navigate.parent, opts("Parent Directory"))
  map("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  map("n", "r", api.tree.reload, opts("Refresh"))
  map("n", "a", api.fs.create, opts("Create"))
  map("n", "d", api.fs.trash, opts("Trash"))
  map("n", "<F2>", api.fs.rename, opts("Rename"))
  map("n", "x", api.fs.cut, opts("Cut"))
  map("n", "y", api.fs.copy.node, opts("Copy"))
  map("n", "p", api.fs.paste, opts("Paste"))
  map("n", "Y", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  map("n", "f", api.live_filter.start, opts("Filter"))
  map("n", "<Esc>", api.live_filter.clear, opts("Clean Filter"))
  map("n", "q", api.tree.close, opts("Close"))
  map("n", "c", api.tree.collapse_all, opts("Collapse"))
  map("n", "e", api.tree.expand_all, opts("Expand All"))
  map("n", "g?", api.tree.toggle_help, opts("Help"))
  map("n", "<leader>c", api.tree.change_root_to_node, opts("CD"))
  map("n", "i", api.node.show_info_popup, opts("Info"))
end

require("nvim-tree").setup {
  -- setup keymaps using on_attach
  on_attach = on_attach,
  -- disable that old stuff
  disable_netrw = true,
  -- move cursor to nvim-tree once it's open
  hijack_cursor = false,
  reload_on_bufenter = true,
  -- remove defaults
  -- remove_keymaps = true,
  -- disable annoying UI bugs. I found that without width, the size would be all over the place.
  -- Experiment on your own if you want.
  view = {
    adaptive_size = false,
    width = 30,
    side = "left",
    preserve_window_proportions = true,
    -- error and git info
    signcolumn = "yes",
  },
  renderer = {
    root_folder_label = true,
    -- group empty folders
    group_empty = true,
    -- git highlighting
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = true,
      inline_arrows = false,
    },
    icons = {
      -- git icons
      git_placement = "after",
      glyphs = {
        git = {
          -- i didn't really like the ignored icon so i removed it :)
          ignored = "",
        },
      },
    },
    special_files = {
      "Cargo.toml",
      "Makefile",
      "makefile",
      "README.md",
      "CMakeLists.txt",
      "stylua.toml",
      -- haskell "stoofs"
      "stylua.toml",
      "stack.yaml",
      "hie.yaml",
      "package.yaml",
      -- ocaml
      "dune-workspace",
      "dune-project",
      "dune",
      -- git
      ".gitignore",
      ".gitmodules",
      -- docker
      "Dockerfile",
    },
  },
  -- lsp diagnostics
  diagnostics = {
    enable = true,
    -- how often
    debounce_delay = 100,
  },
  -- update external changes
  filesystem_watchers = {
    -- how often
    debounce_delay = 100,
  },
  git = {
    show_on_dirs = true,
    timeout = 1000,
  },
  actions = {
    -- when <leader>c is used, it changes the project root
    change_dir = {
      enable = true,
      global = true,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
    },
  },
  trash = {
    -- confirm on deletion
    require_confirm = true,
  },
  live_filter = {
    -- prompt when using live filter
    prefix = "Search: ",
  },
}
