-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Set the colorscheme
--vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "melange"

-- Setup conform.nvim code formatters
require("conform").setup({
  formatters_by_ft = {
    haskell = { "ormolu" },
  },
})

-- Setup telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>")
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags' })
-- Other keymaps
vim.keymap.set('n', '<leader>dd', "<cmd>lua vim.diagnostic.open_float()<cr>",  {noremap = true})
vim.keymap.set('t', '<ESC>', "<C-\\><C-n>", {noremap = true})

-- Editor Config
local opt = vim.opt

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
opt.belloff        = 'all'                         -- Never ring the bell for any reason
opt.splitbelow     = true                          -- Open horizontal splits below current window
opt.splitright     = true                          -- Open vertical splits to the right of the current window
opt.showmatch      = true                          -- Show matching (), [], or {}
opt.colorcolumn    = '120'                         -- Show the color column
opt.formatoptions  = opt.formatoptions + 'j'       -- Remove comment leader when joining comment lines
opt.formatoptions  = opt.formatoptions + 'n'       -- Smart auto-indenting inside numbered lists
opt.laststatus     = 2                             -- Always show status line
opt.lazyredraw     = true                          -- Don't bother updating screen during macro playback
opt.linebreak      = true                          -- Wrap long lines at characters in 'breakat'
opt.list           = true                          -- Show whitespace

