-- Add the runtime directory to runtimepath for queries
-- This is needed for Nix-managed nvim-treesitter where queries are in runtime/
local nix_ts_path = vim.fn.stdpath("data") .. "/nix/nvim-treesitter"
if vim.fn.isdirectory(nix_ts_path .. "/runtime") == 1 then
  vim.opt.runtimepath:prepend(nix_ts_path .. "/runtime")
end

require('nvim-treesitter').setup()

-- Enable treesitter features for all filetypes
-- Note: Since this config is managed by Nix, parsers are pre-installed
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    -- Skip certain filetypes where treesitter causes issues
    local ft = vim.bo.filetype
    if ft == "latex" or ft == "bibtex" or ft == "tex" then
      return
    end
    
    -- Enable syntax highlighting (provided by Neovim)
    -- Start treesitter for this buffer
    pcall(vim.treesitter.start)
    
    -- Enable indentation (provided by nvim-treesitter)
    -- Uncomment for treesitter indentation:
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Note: Incremental selection keymaps (gnn, grn, grc, grm) are now provided
-- by the treesitter-modules.nvim plugin configured in lazy.lua

