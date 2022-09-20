-------------------- HELPERS -------------------------------

--local vim = require('vim')
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn
local opt = vim.opt


-------------------- OPTIONS -------------------------------
--
-- opts Opts OPTS

cmd 'colorscheme dracula'

local indent, width = 2, 120

opt.colorcolumn = tostring(width) -- Line length marker
--opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
--opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
opt.cursorline = false -- Highlight cursor line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'crqnj' -- Automatic formatting options
opt.hidden = true -- Enable background buffers
opt.ignorecase = false -- Ignore case
opt.joinspaces = false -- No double spaces with join
opt.list = true -- Show some invisible characters
opt.pastetoggle = '<F2>' -- Paste mode
opt.scrolloff = 8 -- Lines of context
opt.shiftround = true -- Round indent
opt.shiftwidth = indent -- Size of an indent
opt.sidescrolloff = 15 -- Columns of context
opt.signcolumn = 'yes' -- Show sign column
opt.smartcase = true -- Do not ignore case with capitals
opt.autoindent = true -- Insert indents automatically
opt.smartindent = true -- Insert indents automatically
opt.cindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = indent -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.textwidth = width -- Maximum width of text
opt.updatetime = 100 -- Delay before swap file is saved
opt.wildmode = { 'longest:full' } -- Command-line completion mode
opt.wrap = false -- Disable line wrap
opt.hlsearch = false -- Don't highlight search results

-------------------- PLUGIN SETUP --------------------------

-- tree
g.nvim_tree_width = 50

-- github / git
require('gitsigns').setup()

-- lsp
--local lspconfig = require('lspconfig')
-- lsp.set_log_level("debug")
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)

  -- if server.name == "eslint" then
  --   print(vim.inspect(opts))
  --   opts.on_attach = function(client, bufnr)
  --     -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
  --     -- the resolved capabilities of the eslint server ourselves!
  --     -- client.resolved_capabilities.document_formatting = true
  --   end
  --   opts.settings = {
  --     -- format = { enable = true }
  --   }
  -- end

  if server.name == "tsserver" then
    opts.on_attach = function(client, bufnr)
      -- client.resolved_capabilities.document_formatting = false
    end
    opts.settings = {
      format = { enable = false },
    }
  end

  server:setup(opts)
  cmd [[ do User LspAttachBuffers ]]
end)

local null_ls = require('null-ls')
null_ls.setup({
  debug = true,
  sources = {
    -- null_ls.builtins.formatting.eslint,
    --null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.black.with({
      command = "/opt/venvs/countfire/bin/black"
    }),
    -- null_ls.builtins.formatting.pg_format.with({
    --   extra_args = { "--keyword-case", "0" }
    -- }),
  },
})


-- trouble
require 'trouble'.setup {}


-- telescope
local actions = require('telescope.actions')
local trouble = require("trouble.providers.telescope")
local previewers = require("telescope.previewers")
-- disable preview for bigger files
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 1000000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end
require('telescope').setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    vimgrep_arguments = {
      'rg',
      '--max-columns=1000',
      --'--max-columns-preview=1000',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      --'--trim',
    },
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' > ',
    color_devicons = true,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-q>"] = actions.send_to_qflist,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<c-Up>"] = actions.cycle_history_prev,
        ["<c-Down>"] = actions.cycle_history_next,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
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
  ensure_installed = {
    'python', 'typescript', 'javascript', 'tsx', 'html', 'css', 'scss',
    'java', 'lua', 'cpp', 'c', 'query', 'vim', 'bash',
    'graphql', 'regex', 'comment', 'jsdoc',
    'toml', 'yaml', 'cmake', 'make', 'dockerfile', 'json',
  },

  highlight = {
    enable = true,
    disable = function(lang, bufnr)
        return api.nvim_buf_get_option(bufnr, 'filetype') == 'html.jinja'
    end,

  },
  indent = { enable = false },
  autotag = { enable = true },
  context_commentstring = { enable = true },
  rainbow = { enable = true, extended_mode = false, },

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
      swap_next = { ['<leader>a'] = '@parameter.inner' },
      swap_previous = { ['<leader>A'] = '@parameter.inner' },
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
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-n>'] = {
      i = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end
    },
    ['<c-p>'] = {
      i = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end
    },
    ['<c-space>'] = {
      i = function()
        if cmp.visible() then
          return cmp.confirm({
            behaviour = cmp.ConfirmBehavior.Insert,
            select = false
          })
        else
          cmp.complete()
        end
      end
    },
    ['<C-y>'] = {
      i = cmp.mapping.confirm({
        behaviour = cmp.ConfirmBehavior.Insert,
        select = true
      }),
    },
    ['<C-e>'] = {
      i = cmp.mapping.abort(),
    }
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'nvim_lsp', keyword_length = 4 },
    { name = 'luasnip' },
    { name = 'buffer',
      keyword_length = 5,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = false,
      menu = {
        nvim_lsp = "[lsp]",
        luasnip = "[snip]",
        buffer = "[buf]",
      }
    }
  }
}
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline', keyword_length = 4 }
  })
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer', keyword_length = 5 },
  }
})


local ls = require "luasnip"
ls.config.set_config {
    history = true,
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 200,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = false,
    store_selection_keys = "<c-s>",
}


-- colors
require 'colorizer'.setup({ '*' },
  {
    RGB      = true; -- #RGB hex codes
    RRGGBB   = true; -- #RRGGBB hex codes
    names    = false; -- "Name" codes like Blue
    RRGGBBAA = true; -- #RRGGBBAA hex codes
    rgb_fn   = true; -- CSS rgb() and rgba() functions
    hsl_fn   = true; -- CSS hsl() and hsla() functions
    css      = true; -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = true; -- Enable all CSS *functions*: rgb_fn, hsl_fn
  }
)

-- icons
require 'nvim-web-devicons'.setup {
  default = true;
}
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


----------------------- UI HACKS ------------------------------

-- borders on popups
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" })
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "single" })

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
