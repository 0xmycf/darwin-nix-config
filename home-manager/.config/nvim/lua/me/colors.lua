-- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316#what-is-semantic-highlighting
local links = {
  ['@lsp.type.namespace'] = '@namespace',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@structure',
  ['@lsp.type.parameter'] = '@parameter',
  ['@lsp.type.variable'] = '@variable',
  ['@lsp.type.property'] = '@property',
  ['@lsp.type.enumMember'] = '@constant',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@method',
  ['@lsp.type.macro'] = '@macro',
  ['@lsp.type.decorator'] = '@function',
  -- i have no idea why, but otherwise it wont work / link this correctly
  ['@lsp.type.property.lua'] = '@property',
} -- use :Inspect to figure this crap out
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

local colors = {
  purple     = "#BC8BB4",
  white      = "#B3B8C4",
  yellow     = "#E5C07B",
  darkyellow = "#D19A66",
}

-- use :Inspect to figure this crap out
local overrides = {
  -- haskell changes
  ["@constructor.haskell"] = { fg = colors.yellow, fmt = "none" },
  ["@symbol.haskell"]      = { fg = colors.white },
  ["@preproc.haskell"]     = { fg = colors.white },
  ["@repeat.haskell"]      = { fg = colors.purple },
  ["@include.haskell"]     = { fg = colors.purple },
  ["@namespace.haskell"]   = { fg = colors.yellow },
  ["@variable.haskell"]    = { fg = colors.white },
  ["@conditional.haskell"] = { fg = colors.purple },
  ["@operator.haskell"]    = { fg = colors.purple },
  -- Pyhton keywords bold just for testing and fun
  -- ["@keyword.return.python"]      = { fg = colors.yellow, fmt = "bold" },
  -- ["@keyword.function.python"]    = { fg = colors.yellow, fmt = "bold" },
  -- ["@keyword.conditional.python"] = { fg = colors.yellow, fmt = "bold" },
  -- ["@keyword.operator.python"]    = { fg = colors.yellow, fmt = "bold" },
  -- ["@keyword.repeat.python"]    = { fg = colors.yellow, fmt = "bold" },
  ["@variable.parameter"]  = { fg = colors.white },

  -- for debugging
  -- ["@keyword"]             = { fg = colors.purple, fmt = "bold" },

  -- java stuff...
  -- ["@keyword.operator.java"] = { fg = colors.yellow },
  -- go stuff
  -- ["@include.go"]          = { fg = colors.purple, fmt = "bold" },
  -- ["@keyword.go"]          = { fg = colors.purple, fmt = "bold" },
  -- ["@keyword.function.go"] = { fg = colors.purple, fmt = "bold" },
  -- ["@type.go"]             = { fg = colors.yellow, fmt = "bold" },
  -- ["@type.builtin.go"]     = { fg = colors.darkyellow, fmt = "bold" },
  -- ["@conditional.go"]      = { fg = colors.purple, fmt = "bold" },
  -- ["@keyword.return.go"]   = { fg = colors.purple, fmt = "bold" },
  -- gleam
  ["@type.qualifier"]      = { fg = colors.purple },
  -- general stuff
  ["@boolean"]             = { fg = colors.yellow },
  ["@field"]               = { fg = "$red" },
  ["@property"]            = { fg = "$red" },
  ["@type"]                = { fg = colors.yellow, fmt = "italic" },
}

local function color_swap(args)
  local bg = args.fargs[1]
  if bg == "dark" then
    require("onedark").load()
    vim.cmd("set background=dark")
    vim.cmd.colorscheme "onedark"
  elseif bg == "light" then
    require("catppuccin").load()
    vim.cmd("set background=light")
    vim.cmd.colorscheme "catppuccin"
  end
end

vim.api.nvim_create_user_command('ColorSwap', color_swap, { nargs = 1 })

require("onedark").setup {
  -- Change code style
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments  = 'italic',
    keywords  = 'none',
    functions = 'none',
    strings   = 'none',
    variables = 'none'
  },
  colors = colors,
  highlights = overrides,
}

require("onedark").load()

require("catppuccin").setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = {    -- :h background
    light = "latte",
    dark = "mocha",
  },
  styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  color_overrides = {},
  custom_highlights = function(colors)
    return {
      ["@constructor.haskell"] = { fg = colors.yellow },
      ["@symbol.haskell"]      = { fg = colors.white },
      ["@preproc.haskell"]     = { fg = colors.white },
      ["@repeat.haskell"]      = { fg = colors.pink },
      ["@include.haskell"]     = { fg = colors.pink },
      ["@namespace.haskell"]   = { fg = colors.yellow },
      ["@variable.haskell"]    = { fg = colors.white },
      -- ["@conditional.haskell"] = { fg = colors.pink }, -- ???
      ["@operator.haskell"]    = { fg = colors.pink },
      ["@type"]                = { fg = colors.yellow },
      ["@variable.parameter"]  = { fg = colors.text },
      ["@module"]              = { fg = colors.yellow },
    }
  end,
})

-- setup must be called before loading
-- vim.cmd.colorscheme "catppuccin"
