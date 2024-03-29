local M = {
  cmd = function(events)
    return function(opts)
      vim.api.nvim_create_autocmd(events, opts)
    end
  end,
  group = function(name)
    return vim.api.nvim_create_augroup(name, {
      clear = true,
    })
  end,
}

local group = M.group
local cmd = M.cmd

cmd("FileType") {
  pattern = {
    "ml",
    "ocaml",
    "lua",
    "markdown",
    "haskell",
    "lhaskell",
    "cabal",
    "scala",
    "purescript",
    "purs",
    "tex",
    "latex",
    "svelte",
    "html",
    "typst",
    "nix",
    "r",
    "rmd",
    "gleam",
  },
  callback = function(ev)
    local local_opts = {
      tabstop = 2,
      softtabstop = 2,
      shiftwidth = 2,
    }

    for key, value in pairs(local_opts) do
      vim.bo[ev.buf][key] = value
    end

    vim.cmd('set indentkeys-=}')
    vim.cmd('set indentkeys-={')
    vim.cmd('set indentkeys-=[')
    vim.cmd('set indentkeys-=]')
  end,
  group = group("tab_width"),
}

cmd("FileType") {
  pattern = { "haskell", "bqn" },
  callback = function()
    vim.o.spell = false
  end,
  group = group("nospellcheck"),
}

cmd("FileType") {
  pattern = { "go" },
  callback = function(ev)
    local local_opts = {
      tabstop = 4,
      shiftwidth = 4,
    }

    for key, value in pairs(local_opts) do
      vim.bo[ev.buf][key] = value
    end
    vim.cmd('set noexpandtab')

    vim.cmd('set indentkeys-=}')
    vim.cmd('set indentkeys-={')
    vim.cmd('set indentkeys-=[')
    vim.cmd('set indentkeys-=]')
  end,
  group = group("go_tab_width"),
}

cmd("FileType") {
  pattern = { "rmd" },
  callback = function()
    vim.cmd('set conceallevel=0')
  end,
  group = group("nospellcheck"),
}

return M
