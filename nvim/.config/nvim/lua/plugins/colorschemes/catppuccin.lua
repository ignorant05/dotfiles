theme = {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Ensures early loading
		lazy = false, -- Load immediately (optional)
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- Or explicitly set your preferred flavor
				transparent_background = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					mason = true, -- Consider adding
					telescope = true, -- Popular integration
					which_key = true, -- If you use which-key
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
					},
				},
				custom_highlights = function(colors)
					return {
						-- Example custom highlight:
						LineNr = { fg = colors.overlay1 },
						CursorLineNr = { fg = colors.lavender, style = { "bold" } },
					}
				end,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
}

return theme
