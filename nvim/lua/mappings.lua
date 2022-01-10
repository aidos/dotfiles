
-------------------- HELPERS -------------------------------

--local vim = require('vim')
local api, cmd, g, lsp, fn = vim.api, vim.cmd, vim.g, vim.lsp, vim.fn

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end


-------------------- MAPPINGS ------------------------------

g.mapleader = " "

-- copy / paste
map('n', '<leader>c', '"+y')
map('n', '<leader>v', '"+p')

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
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
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

