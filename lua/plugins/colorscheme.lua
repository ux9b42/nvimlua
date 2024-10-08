local everforest = {
	'neanias/everforest-nvim',
	priority = 1000,
	config = function()
		local o = vim.o

		vim.cmd([[
			set background=dark termguicolors
			colorscheme everforest
		]])
	end
}


return everforest
