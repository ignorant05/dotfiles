plugin = {
	"nvzone/floaterm",
	dependencies = "nvzone/volt",
	opts = {},
	cmd = "FloatermToggle",
	config = {
		border = false,
		size = { h = 75, w = 92 },

		-- to use, make this func(buf)
		mappings = {
			-- term = function(buf)
			-- 	vim.keymap.set({ "n", "t" }, "<leader>t", function()
			-- 		require("floaterm.api").cycle_term_bufs("prev")
			-- 	end, { buffer = buf })
			-- end,
		},

		-- Default sets of terminals you'd like to open
		terminals = {
			{ name = "Initial", buffer = true },
			-- cmd can be function too
			-- { name = "Terminal", cmd = "neofetch" },
			-- More terminals
		},
	},
}

return plugin
