return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local setmap = vim.keymap.set

		local tb = require('telescope.builtin')
		setmap('n', '<leader>ff', tb.find_files, {})
		setmap('n', '<leader>fg', tb.live_grep, {})
		setmap('n', '<leader>fb', tb.buffers, {})
		setmap('n', '<leader>fh', tb.help_tags, {})
	end
}
