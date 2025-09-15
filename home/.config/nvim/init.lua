vim.pack.add {
    -- LSP
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
    { src = 'https://github.com/mrcjkb/haskell-tools.nvim' }, -- Mason requires GHCup which is not available on Nix, hence this instead
    -- Colorscheme
    { src = 'https://github.com/catppuccin/nvim' },
}

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        "hlint",
        "rust_analyzer",
    }
})

local opt = vim.opt

-- Make sure the updated leader mapping is done early
vim.g.mapleader = ' '                              -- Map leader to space

-- A tab is four spaces
local tabsize = 4

opt.number         = true                          -- Show line numbers in gutter
opt.relativenumber = true                          -- Show relative numbers in gutter
opt.textwidth      = 120                           -- Automatically hard wrap at column
opt.scrolloff      = 3                             -- Start scrolling n lines before edge of viewport
opt.cursorline     = true                          -- Highlight current line
opt.expandtab      = true                          -- Always use spaces instead of tabs
opt.shiftwidth     = tabsize                       -- Spaces per tab (when shifting)
opt.tabstop        = tabsize                       -- Spaces per tab
opt.showbreak      = '↳ '                          -- Downwards arrow with tip rightwards (U+21B3, UTF-8: E2 86 B3)
opt.smarttab       = true                          -- <tab>/<BS> indent/dedent in leading whitespace

-- Colorscheme
vim.cmd.colorscheme "catppuccin-mocha"
