local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ 'neanias/everforest-nvim', priority = 1000 },
	{ 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
}

require('lazy').setup(plugins)

local setmap = vim.keymap.set
vim.g.mapleader = ' '

-- telescope keymapping
local tb = require('telescope.builtin')
setmap('n', '<leader>ff', tb.find_files, {})
setmap('n', '<leader>fg', tb.live_grep, {})
setmap('n', '<leader>fb', tb.buffers, {})
setmap('n', '<leader>fh', tb.help_tags, {})

require('nvim-treesitter.configs').setup({
	ensure_installed = { 'lua', 'javascript', 'html' },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.cmd([[
	set noexpandtab relativenumber
	set tabstop=2 softtabstop=2 shiftwidth=2
	set hidden noswapfile nobackup
	set fillchars=eob:\ 
	set nowrap

	set background=dark termguicolors
	colorscheme everforest
]])
