
-------------------- HELPERS -------------------------------

--local vim = require('vim')
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn
local opt = vim.opt

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end



-------------------- OPTIONS -------------------------------
--
-- opts Opts OPTS

cmd 'colorscheme dracula'

local indent, width = 2, 150

opt.colorcolumn = tostring(width)   -- Line length marker
--opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
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
opt.autoindent = true               -- Insert indents automatically
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
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--map('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>')

-- trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references<cr>')



-------------------- PLUGIN SETUP --------------------------

-- tree
g.nvim_tree_width = 50

-- octo / github
require"octo".setup()

-- lsp
--local lspconfig = require('lspconfig')
-- lsp.set_log_level("debug")
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    cmd [[ do User LspAttachBuffers ]]
end)


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
  indent = { enable = false },
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

local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
})


require('nvim-autopairs').setup{
  check_ts = true,
  enable_check_bracket_line = false,
}
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true,  -- auto select first item
  insert = false,
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
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

-- stops windows shuffling about
require("stabilize").setup()

