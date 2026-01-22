plugin = {
	"iabdelkareem/csharp.nvim",
	dependencies = {
		"williamboman/mason.nvim", -- Automatically installs omnisharp
		"mfussenegger/nvim-dap",
		"Tastyep/structlog.nvim", -- Optional
	},
	config = function()
		-- Mason must be initialized before csharp.nvim
		require("mason").setup()

		-- Setup csharp.nvim with LSP and DAP options
		require("csharp").setup({
			lsp = {
				omnisharp = {
					enable = true,
					cmd_path = nil, -- leave nil to let csharp.nvim handle it
					default_timeout = 1000,
					enable_editor_config_support = true,
					organize_imports = true,
					load_projects_on_demand = false,
					enable_analyzers_support = true,
					enable_import_completion = true,
					include_prerelease_sdks = true,
					analyze_open_documents_only = false,
					enable_package_auto_restore = true,
					debug = false,
				},
				roslyn = { enable = false, cmd_path = nil },
				capabilities = nil,
				on_attach = nil,
			},
			dap = {
				adapter_name = nil, -- Use default adapter
			},
			logging = { level = "INFO" },
		})
	end,
}
return plugin
