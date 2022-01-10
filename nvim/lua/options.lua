
-------------------- HELPERS -------------------------------

--local vim = require('vim')
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn
local opt = vim.opt


-------------------- OPTIONS -------------------------------
--
-- opts Opts OPTS

cmd 'colorscheme dracula'

local indent, width = 2, 120

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
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
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
    update_in_insert = false,
  }
)

-- stops windows shuffling about
require("stabilize").setup()

