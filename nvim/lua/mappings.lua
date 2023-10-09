-------------------- HELPERS -------------------------------

--local vim = require('vim')
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- MAPPINGS ------------------------------

g.mapleader = " "

-- copy / paste
-- map('n', '<leader>c', '"+y')
map('n', '<leader>v', '"+p')
-- copy to clipboard
map('v', '<leader>c', "y:call SendViaOSC52(getreg('\"'))<cr>", { silent = true })

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
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- better search in command history
map('c', '<c-n>', 'wildmenumode() ? "\\<c-n>" : "\\<down>"', { expr = true })
map('c', '<c-p>', 'wildmenumode() ? "\\<c-p>" : "\\<up>"', { expr = true })

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true })<CR>')
map('n', '<leader>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>')
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>fo', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ft', '<cmd>Telescope builtin<CR>')
map('n', '<leader>fq', '<cmd>Telescope quickfix<CR>')

---- fugitive and git
local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
map('n', '<leader>g<space>', ':Git ')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gl', string.format('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))
map('n', '<leader>gm', '<cmd>MergetoolToggle<CR>')

-- lsp
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', 'F', '<cmd>lua vim.lsp.buf.format()<CR>')
map('v', 'F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float(0, {scope="line", border="single"})<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--map('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>')

-- trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references<cr>')

-- quickfix
-- vim.api.nvim_command([[
--   function! QuickfixMapping()
--     " open current quickfix entry
--     nnoremap <buffer> o <CR>zz<c-w>w
--     " go to the previous location and stay in the quickfix window
--     nnoremap <buffer> K :cprev<CR>zz<c-w>w
--     " go to the next location and stay in the quickfix window
--     nnoremap <buffer> J :cnext<CR>zz<c-w>w
--   endfunction

--   augroup quickfix_group
--     autocmd!
--     autocmd filetype qf call QuickfixMapping()
--   augroup END
-- ]])


-- snippets
ls = require('luasnip')
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
map("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/setup/luasnip.lua<CR>")
