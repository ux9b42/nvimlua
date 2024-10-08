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
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
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

vim.cmd([[
	set noexpandtab relativenumber
	set tabstop=2 softtabstop=2 shiftwidth=2
	set hidden noswapfile nobackup
	set fillchars=eob:\ 
	set nowrap

	set background=dark termguicolors
	colorscheme everforest
]])
