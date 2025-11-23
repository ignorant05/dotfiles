plugin = {
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"mfussenegger/nvim-jdtls",
			"folke/neoconf.nvim",
		},
		config = function()
			-- Initialize neoconf FIRST
			require("neoconf").setup()

			local has_jdtls = pcall(require("mason-registry").get_package, "jdtls")
			if not has_jdtls then
				vim.notify("jdtls is not available yet from mason", vim.log.levels.ERROR)
				return
			end

			-- Setup core java functionality
			require("java").setup()

			-- Configure JDTLS through nvim-java's wrapper
			require("java").setup_jdtls({
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-17",
									path = "/opt/jdk-17",
									default = true,
								},
							},
						},
					},
				},
			})
		end,
		ft = { "java" },
		-- init = function()
		-- 	-- Only install if not already present
		-- 	if not require("mason-registry").is_installed("jdtls") then
		-- 		vim.cmd([[MasonInstall jdtls java-test java-debug-adapter]])
		-- 	end
		-- end,
	},
}

return plugin
