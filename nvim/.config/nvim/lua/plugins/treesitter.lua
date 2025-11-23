plugin = {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"jsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"c",
			"rust",
			"go",
			"java",
		},
	},
}

return plugin
