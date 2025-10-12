vim.pack.add {
    -- LSP
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- { src = 'https://github.com/mrcjkb/haskell-tools.nvim' }, -- Mason requires GHCup which is not available on Nix, hence this instead
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' },
    -- Colorscheme
    { src = 'https://github.com/catppuccin/nvim' },
    -- Telescope
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' }, -- required by neo-tree/telescope
    --
    { src = 'https://github.com/OXY2DEV/markview.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },
    { src = 'https://github.com/mrcjkb/haskell-tools.nvim' },
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
    { src = 'https://github.com/MunifTanjim/nui.nvim' }, -- required by neo-tree
}

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        -- "hlint",
        -- "hls",
        "rust_analyzer",
        "pylyzer",
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

local builtin = require('telescope.builtin')
local telescope = require('telescope')
telescope.setup {
    pickers = {
        find_files = {
            hidden = true
        }
    }
}
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>")
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "haskell" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("tiny-inline-diagnostic").setup({
    -- Style preset for diagnostic messages
    -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
    preset = "modern",

    -- Set the background of the diagnostic to transparent
    transparent_bg = false,

    -- Set the background of the cursorline to transparent (only for the first diagnostic)
    -- Default is true in the source code, not false as in the old README
    transparent_cursorline = true,

    signs = {
        left = "",       -- Left border character
        right = "",      -- Right border character
        diag = "●",       -- Diagnostic indicator character
        arrow = "    ",   -- Arrow pointing to diagnostic
        up_arrow = "    ", -- Upward arrow for multiline
        vertical = " │",   -- Vertical line for multiline
        vertical_end = " └", -- End of vertical line for multiline
    },

    blend = {
        factor = 0.22,    -- Transparency factor (0.0 = transparent, 1.0 = opaque)
    },
    hi = {
        -- Highlight group for error messages
        error = "DiagnosticError",

        -- Highlight group for warning messages
        warn = "DiagnosticWarn",

        -- Highlight group for informational messages
        info = "DiagnosticInfo",

        -- Highlight group for hint or suggestion messages
        hint = "DiagnosticHint",

        -- Highlight group for diagnostic arrows
        arrow = "NonText",

        -- Background color for diagnostics
        -- Can be a highlight group or a hexadecimal color (#RRGGBB)
        background = "CursorLine",

        -- Color blending option for the diagnostic background
        -- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
        -- Default is "Normal" in the source code
        mixing_color = "Normal",
    },

    options = {
        -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
        show_source = {
            enabled = false,
            -- Show source only when multiple sources exist for the same diagnostic
            if_many = false,
        },

        -- Use icons defined in the diagnostic configuration instead of preset icons
        use_icons_from_diagnostic = false,

        -- Set the arrow icon to the same color as the first diagnostic severity
        set_arrow_to_diag_color = false,

        -- Add messages to diagnostics when multiline diagnostics are enabled
        -- If set to false, only signs will be displayed
        add_messages = true,

        -- Time (in milliseconds) to throttle updates while moving the cursor
        -- Increase this value for better performance on slow computers
        -- Set to 0 for immediate updates and better visual feedback
        throttle = 20,

        -- Minimum message length before wrapping to a new line
        softwrap = 30,

        -- Configuration for multiline diagnostics
        -- Can be a boolean or a table with detailed options
        multilines = {
            -- Enable multiline diagnostic messages
            enabled = false,

            -- Always show messages on all lines for multiline diagnostics
            always_show = false,

            -- Trim whitespaces from the start/end of each line
            trim_whitespaces = false,

            -- Replace tabs with this many spaces in multiline diagnostics
            tabstop = 4,
        },

        -- Display all diagnostic messages on the cursor line, not just those under cursor
        show_all_diags_on_cursorline = false,

        -- Enable diagnostics in Insert mode
        -- If enabled, consider setting throttle to 0 to avoid visual artifacts
        enable_on_insert = false,

        -- Enable diagnostics in Select mode (e.g., when auto-completing with Blink)
        enable_on_select = false,

        -- Manage how diagnostic messages handle overflow
        overflow = {
            -- Overflow handling mode:
            -- "wrap" - Split long messages into multiple lines
            -- "none" - Do not truncate messages
            -- "oneline" - Keep the message on a single line, even if it's long
            mode = "wrap",

            -- Trigger wrapping this many characters earlier when mode == "wrap"
            -- Increase if the last few characters of wrapped diagnostics are obscured
            padding = 0,
        },

        -- Configuration for breaking long messages into separate lines
        break_line = {
            -- Enable breaking messages after a specific length
            enabled = false,

            -- Number of characters after which to break the line
            after = 30,
        },

        -- Custom format function for diagnostic messages
        -- Function receives a diagnostic object and should return a string
        -- Example: function(diagnostic) return diagnostic.message .. " [" .. diagnostic.source .. "]" end
        format = nil,

        -- Virtual text display configuration
        virt_texts = {
            -- Priority for virtual text display (higher values appear on top)
            -- Increase if other plugins (like GitBlame) override diagnostics
            priority = 2048,
        },

        -- Filter diagnostics by severity levels
        -- Available severities: vim.diagnostic.severity.ERROR, WARN, INFO, HINT
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        -- Events to attach diagnostics to buffers
        -- Default: { "LspAttach" }
        -- Only change if the plugin doesn't work with your configuration
        overwrite_events = nil,
    },

    -- List of filetypes to disable the plugin for
    disabled_ft = {}
})

vim.o.complete = ".,o" -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noselect" -- add 'popup' for docs (sometimes)
vim.o.autocomplete = true
vim.o.pumheight = 7

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
      -- Optional formating of items
      convert = function(item)
        -- Remove leading misc chars for abbr name,
        -- and cap field to 25 chars
        --local abbr = item.label
        --abbr = abbr:match("[%w_.]+.*") or abbr
        --abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr
        --
        -- Remove return value
        --local menu = ""

        -- Only show abbr name, remove leading misc chars (bullets etc.),
        -- and cap field to 15 chars
        local abbr = item.label
        abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
        abbr = abbr:match("[%w_.]+.*") or abbr
        abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

        -- Cap return value field to 15 chars
        local menu = item.detail or ""
        menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

        return { abbr = abbr, menu = menu }
      end,
    })
  end,
})
