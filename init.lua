-- neovim config
-- github.com/ojroques

-------------------- HELPERS -------------------------------
local api, cmd, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'dracula/vim'}
paq {'norcalli/nvim-colorizer.lua'}
paq {'neovim/nvim-lspconfig'}
paq {'kabouzeid/nvim-lspinstall'}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'nvim-treesitter/nvim-treesitter-textobjects'}
paq {'savq/paq-nvim', opt = true}
paq {'hrsh7th/nvim-compe'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim', run='git submodule update --init --recursive'}
paq {'nvim-telescope/telescope-fzf-native.nvim', run='make'}
paq {'folke/trouble.nvim'}
paq {'kyazdani42/nvim-web-devicons'}
-- paq {'airblade/vim-gitgutter'}
-- paq {'airblade/vim-rooter'}
-- paq {'ojroques/nvim-bufbar'}
-- paq {'ojroques/nvim-bufdel'}
-- paq {'ojroques/nvim-buildme'}
-- paq {'ojroques/nvim-hardline'}
-- paq {'ojroques/vim-oscyank'}
-- paq {'tpope/vim-commentary'}
-- paq {'tpope/vim-fugitive'}
-- paq {'tpope/vim-unimpaired'}

-------------------- PLUGIN SETUP --------------------------
g.mapleader = " "

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ft', '<cmd>Telescope builtin<CR>')
map('n', '<leader>fq', '<cmd>Telescope quickfix<CR>')

---- fugitive and git
--local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
---- map('n', '<leader>g<space>', ':Git ')
---- map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
---- map('n', '<leader>gg', '<cmd>Git<CR>')
---- map('n', '<leader>gl', fmt('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))

-------------------- OPTIONS -------------------------------
local indent, width = 2, 80
cmd 'colorscheme dracula'

opt.colorcolumn = tostring(width)   -- Line length marker
--opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.completeopt = {'menuone', 'noselect'}  -- Completion options
opt.cursorline = false              -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.formatoptions = 'crqnj'         -- Automatic formatting options
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = false              -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.pastetoggle = '<F2>'            -- Paste mode
opt.scrolloff = 8                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent             -- Size of an indent
opt.sidescrolloff = 15              -- Columns of context
opt.signcolumn = 'yes'              -- Show sign column
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.textwidth = width               -- Maximum width of text
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.hlsearch = false                -- Don't highlight search results

-------------------- MAPPINGS ------------------------------
-- copy / paste
map('', '<leader>c', '"+y')
map('n', '<leader>v', '"+p')
--map('i', '<C-u>', '<C-g>u<C-u>')
--map('i', '<C-w>', '<C-g>u<C-w>')
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', 'jj', '<ESC>')
map('t', 'jj', '<ESC>', {noremap = false})
--map('n', '<C-w>T', '<cmd>tabclose<CR>')
--map('n', '<C-w>t', '<cmd>tabnew<CR>')
-- Y to act like D and C
map('n', 'Y', 'y$')
-- nicer up / down on wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- jump through quickfix list
map('n', 'gn', '<cmd>cn<CR>')
map('n', 'gp', '<cmd>cp<CR>')

-- window controls
map('n', '<S-Down>', '<C-w>2-')
map('n', '<S-Up>', '<C-w>2+')
map('n', '<S-Left>', '<C-w>2>')
map('n', '<S-Right>', '<C-w>2<')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader>s', ':%s//gcI<Left><Left><Left><Left>')
map('v', '<leader>s', ':s//gcI<Left><Left><Left><Left>')

-- settings I might want
--" Invisible character colors
--highlight NonText guifg=#4a4a59
--highlight SpecialKey guifg=#4a4a59

-------------------- TEXT OBJECTS --------------------------
-- for _, ch in ipairs({
--   '<space>', '!', '#', '$', '%', '&', '*', '+', ',', '-', '.',
--   '/', ':', ';', '=', '?', '@', '<bslash>', '^', '_', '~', '<bar>',
-- }) do
--   map('x', fmt('i%s', ch), fmt(':<C-u>normal! T%svt%s<CR>', ch, ch), {silent = true})
--   map('o', fmt('i%s', ch), fmt(':<C-u>normal vi%s<CR>', ch), {silent = true})
--   map('x', fmt('a%s', ch), fmt(':<C-u>normal! F%svf%s<CR>', ch, ch), {silent = true})
--   map('o', fmt('a%s', ch), fmt(':<C-u>normal va%s<CR>', ch), {silent = true})
-- end

-------------------- LSP -----------------------------------
local lsp = require('lspconfig')
--vim.lsp.set_log_level("debug")
require'lspinstall'.setup()
for ls, cfg in pairs({
  bashls = {},
  ccls = {},
  jsonls = {},
  lua = {},
  pyright = {},
  tsserver = {},
  tailwindcss = {},
}) do lsp[ls].setup(cfg) end

-- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
--map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'F', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "single"})<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
--map('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')


-------------------- TELESCOPE -----------------------------
local actions = require('telescope.actions')
local trouble = require("trouble.providers.telescope")
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--max-columns=1000',
            --'--max-columns-preivew=1000',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-t>"] = trouble.open_with_trouble,
            },
            n = {
              ["<C-t>"] = trouble.open_with_trouble,
            },
        },
        file_ignore_patterns = { "node_modules" }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzf')


-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
        ['ac'] = '@class.outer', ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']a'] = '@parameter.outer',
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_previous_start = {
        ['[a'] = '@parameter.outer',
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
    },
  },
}

-- -------------------- COMPLETION ------------------------------
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  --throttle_time = 80,
  min_length = 1,
  --preselect = 'disable', -- 'enable' / 'always'
  documentation = {
    border = 'single', -- the border option is the same as `|help nvim_open_win|`
    -- winhighlight = 'CompeDocumentation', -- highlight group used for the documentation window
    -- max_width = 120,
    -- min_width = 40,
    -- max_height = math.floor(vim.o.lines * 0.3),
    -- min_height = 1,
  },
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true,
  },
}

require'colorizer'.setup({'*'},
  {
    RGB      = true;         -- #RGB hex codes
    RRGGBB   = true;         -- #RRGGBB hex codes
    names    = false;         -- "Name" codes like Blue
    RRGGBBAA = true;         -- #RRGGBBAA hex codes
    rgb_fn   = true;         -- CSS rgb() and rgba() functions
    hsl_fn   = true;         -- CSS hsl() and hsla() functions
    css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
  }
)

require'trouble'.setup{ }
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references<cr>')

require'nvim-web-devicons'.setup {
-- -- your personnal icons can go here (to override)
-- -- DevIcon will be appended to `name`
-- override = {
--  zsh = {
--    icon = "",
--    color = "#428850",
--    name = "Zsh"
--  }
-- };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single"
  }
)

