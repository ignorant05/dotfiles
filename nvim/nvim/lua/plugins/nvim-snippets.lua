plugin = {
	{
		"garymjr/nvim-snippets",
		keys = {
			{
				-- "<Tab>",
				"<A-k>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<A-k>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				-- "<S-Tab>",
				"<A-j>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<A-j>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
}

return plugin
