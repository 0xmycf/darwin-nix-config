local cmp = require("cmp")
_AUTOPAIRS_INIT = false

local kind_icons = {
  Text          = "",
  Method        = "",
  Function      = "",
  Constructor   = "",
  Field         = "",
  Variable      = "",
  Class         = "ﴯ",
  Interface     = "",
  Module        = "",
  Property      = "ﰠ",
  Unit          = "",
  Value         = "",
  Enum          = "",
  Keyword       = "",
  Snippet       = "",
  Color         = "",
  File          = "",
  Reference     = "",
  Folder        = "",
  EnumMember    = "",
  Constant      = "",
  Struct        = "",
  Event         = "",
  Operator      = "",
  TypeParameter = "",
  Copilot       = "™", -- use :tm: because it will steal your code
}

-- https://github.com/zbirenbaum/copilot-cmp
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end


local next = function(fallback)
  if cmp.visible() then
    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  else
    fallback()
  end
end

local prev = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
  else
    fallback()
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered {
      border = "single",
    },
    documentation = cmp.config.window.bordered {
      border = "single",
    },
  },
  preselect = cmp.PreselectMode.Item,
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
    completeopt = "menu,menuone,noselect",
  },
  formatting = {
    fields = {
      "abbr",
      "menu",
      "kind",
    },
    format = function(_, item)
      item.kind = kind_icons[item.kind] .. " " .. item.kind
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(4),
    ["<C-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-+>"] = cmp.mapping.complete(),
    ["±"] = cmp.mapping.abort(), -- <M-+>

    ["<C-j>"] = cmp.mapping(next, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(next, { "i", "s" }),

    ["<C-k>"] = cmp.mapping(prev, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(prev, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources({
    -- Copilot Source
    { name = "copilot",   group_index = 2 },

    -- other
    { name = "nvim_lsp",  priority = 9 },
    { name = "vsnip" },
    { name = "path",      trigger_characters = { "/" }, priority = 10 },
    -- pandoc
    { name = "cmp_pandoc" },
  }, {
    { name = "buffer" },
  }),
}

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

if not _AUTOPAIRS_INIT then
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  _AUTOPAIRS_INIT = true
end
