
-- neovim config


-------------------- HELPERS -------------------------------

--local vim = require'vim'
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end


-------------------- PLUGINS -------------------------------

cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq { 'savq/paq-nvim', opt = true }

paq { 'dracula/vim' }
paq { 'kyazdani42/nvim-web-devicons' }
paq { 'norcalli/nvim-colorizer.lua' }
paq { 'nvim-lua/popup.nvim' }
paq { 'ntpeters/vim-better-whitespace' }
paq { 'p00f/nvim-ts-rainbow' }

paq { 'neovim/nvim-lspconfig' }
paq { 'kabouzeid/nvim-lspinstall' }
paq { 'nvim-treesitter/nvim-treesitter' }
paq { 'nvim-treesitter/playground' }
paq { 'nvim-treesitter/nvim-treesitter-textobjects' }
paq { 'RRethy/nvim-treesitter-textsubjects' }

paq { 'hrsh7th/nvim-compe' }
paq { 'windwp/nvim-autopairs' }
paq { 'windwp/nvim-ts-autotag' }
paq { 'tpope/vim-commentary' }
paq { 'JoosepAlviste/nvim-ts-context-commentstring' }
paq { 'mg979/vim-visual-multi' }

paq { 'nvim-lua/plenary.nvim' }
paq { 'nvim-telescope/telescope.nvim', run='git submodule update --init --recursive' }
paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }
paq { 'folke/trouble.nvim' }

paq { 'tpope/vim-fugitive' }
paq { 'pwntester/octo.nvim' }

paq { 'kyazdani42/nvim-tree.lua' }

paq { 'aidos/vim-simpledb' }


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
opt.cindent = true                  -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.textwidth = width               -- Maximum width of text
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'longest:full'}     -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.hlsearch = false                -- Don't highlight search results

--vim.wo.foldmethod = 'expr'
--vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'


-------------------- MAPPINGS ------------------------------

g.mapleader = " "

-- copy / paste
map('n', '<leader>c', '"+y')
map('n', '<leader>v', '"+p')

-- tab / shift-tab to move through completes
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('i', 'jj', '<ESC>')
-- Y to act like D and C
map('n', 'Y', 'y$')
-- nicer up / down on wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- jump through quickfix list
map('n', 'gn', '<cmd>cn<CR>')
map('n', 'gp', '<cmd>cp<CR>')

-- window controls
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- shortcut search and replace
map('n', '<leader>s', ':%s///gcI<Left><Left><Left><Left>')
map('v', '<leader>s', ':s///gcI<Left><Left><Left><Left>')

-- better search in command history
map('c', '<C-n>', 'wildmenumode() ? "\\<c-n>" : "\\<down>"', {expr = true})
map('c', '<C-p>', 'wildmenumode() ? "\\<c-p>" : "\\<up>"', {expr = true})

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ft', '<cmd>Telescope builtin<CR>')
map('n', '<leader>fq', '<cmd>Telescope quickfix<CR>')

map('n', '<leader>fd', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>fc', '<cmd>NvimTreeFindFile<CR>')

---- fugitive and git
local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
map('n', '<leader>g<space>', ':Git ')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gl', string.format('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))

-- lsp
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', 'F', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "single"})<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
--map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--map('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>')

-- trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references<cr>')


-- text objects
-- for _, ch in ipairs({
--   '<space>', '!', '#', '$', '%', '&', '*', '+', ',', '-', '.',
--   '/', ':', ';', '=', '?', '@', '<bslash>', '^', '_', '~', '<bar>',
-- }) do
--   map('x', fmt('i%s', ch), fmt(':<C-u>normal! T%svt%s<CR>', ch, ch), {silent = true})
--   map('o', fmt('i%s', ch), fmt(':<C-u>normal vi%s<CR>', ch), {silent = true})
--   map('x', fmt('a%s', ch), fmt(':<C-u>normal! F%svf%s<CR>', ch, ch), {silent = true})
--   map('o', fmt('a%s', ch), fmt(':<C-u>normal va%s<CR>', ch), {silent = true})
-- end



-------------------- PLUGIN SETUP --------------------------

-- tree
g.nvim_tree_width = 50

-- octo / github
require"octo".setup()

-- lsp
local lspconfig = require('lspconfig')
-- lsp.set_log_level("debug")
require'lspinstall'.setup()
for ls, cfg in pairs({
  bash = {},
  json = {},
  lua = {},
  python = {},
  typescript = {},
  java = {},
  --tailwindcss = {},
}) do lspconfig[ls].setup(cfg) end


-- trouble
require'trouble'.setup{ }


-- telescope
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
        prompt_prefix = ' > ',
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


-- tree-sitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',

  highlight = { enable = true },
  autotag = { enable = true },
  autopairs = { enable = true },
  context_commentstring = { enable = true },
  rainbow = { enable = true },

  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    }
  },

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
    peek_definition_code = {
      ["df"] = "@function.outer",
      ["dF"] = "@class.outer",
    },
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

-- completion
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

require('nvim-autopairs').setup{
  check_ts = true
}
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false,  -- auto select first item
})


-- colors
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

-- icons
require'nvim-web-devicons'.setup {
 default = true;
}
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


----------------------- UI HACKS ------------------------------

-- borders on popups
lsp.handlers["textDocument/hover"] = lsp.with( lsp.handlers.hover, { border = "single" })
lsp.handlers["textDocument/signatureHelp"] = lsp.with( lsp.handlers.signature_help, { border = "single" })

-- restore previous cursor location when opening files
api.nvim_command([[
augroup AutoCompileLatex
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
augroup END
]])

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    update_in_insert = true,
  }
)

