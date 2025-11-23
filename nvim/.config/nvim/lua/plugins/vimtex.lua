local plugin = {
	"lervag/vimtex",
	lazy = false, -- lazy-loading will disable inverse search
	config = function()
		vim.g.vimtex_view_method = "zathura"
		-- vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "./.latexmk/aux",
			out_dir = "./.latexmk/out",
		}
	end,
	keys = {
		{ "<localLeader>l", "", desc = "+vimtex" },
	},
}

return plugin
