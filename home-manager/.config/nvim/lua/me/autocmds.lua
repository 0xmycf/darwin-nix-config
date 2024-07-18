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
    pattern = { "sql" },
    callback = function()
        vim.g.omni_sql_no_default_maps = 1
        vim.g.ftplugin_sql_omni_key = '<leader>sql'
        vim.cmd [[
    let b:did_ftplugin = 1
    " unmap <buffer> <C-C>R
    " unmap <buffer> <C-C>L
    " unmap <buffer> <C-C>l
    " unmap <buffer> <C-C>c
    " unmap <buffer> <C-C>v
    " unmap <buffer> <C-C>p
    " unmap <buffer> <C-C>t
    " unmap <buffer> <C-C>s
    " unmap <buffer> <C-C>T
    " unmap <buffer> <C-C>o
    " unmap <buffer> <C-C>f
    " unmap <buffer> <C-C>k
    " unmap <buffer> <C-C>a
    ]]
    end,
    group = group("sql_omni"),
}

cmd("FileType") {
    pattern = {
        "ml",
        "ocaml",
        "lua",
        "ruby",
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
        "racket",
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

cmd("BufEnter") {
    pattern = { "*" },
    callback = function()
        vim.cmd [[
    set formatoptions-=r
    setlocal formatoptions-=r
  ]]
    end,
}

local function file_name()
    local name = vim.fn.expand "%:t"
    if name == "" then
        return nil
    else
        return name
    end
end

cmd("BufEnter") {
    pattern = { "*" },
    callback = function()
        local name = file_name()
        if name ~= nil then
            local _, err = pcall(vim.cmd, "loadview")
            if err ~= nil and err ~= "" then
                vim.print("No view found for " .. name)
                print("Error is: " .. vim.inspect(err))
            end
        end
    end,
}

cmd("BufWinLeave") {
    pattern = { "*" },
    callback = function()
        if file_name() ~= nil then
            vim.cmd "mkview"
        end
    end,
}

cmd("VimEnter") {
    callback = function()
        if vim.o.background == "dark" then
            require("onedark").load()
            vim.cmd.colorscheme "onedark"
        else
            vim.cmd.colorscheme "catppuccin"
        end
        -- this fixes lualine, because otherwise there is some weird bug
        require("me.plugins.lualine")
    end,
}

return M
