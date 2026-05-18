plugin = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"vhyrro/luarocks.nvim",
		-- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false,
	---@module "neo-tree"
	---@type neotree.Config?
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignore = false,
				},
			},

			window = {
				mappings = {
					["l"] = "open",
					["h"] = "shrink_dir",
				},
			},
			commands = {
				navigate_up_and_close = function(state)
					local fs = require("neo-tree.sources.filesystem")
					local utils = require("neo-tree.utils")
					local parent_path, _ = utils.split_path(state.path)
					if not utils.truthy(parent_path) then
						return
					end
					local path_to_reveal = nil
					local node = state.tree:get_node()
					if node then
						path_to_reveal = node:get_id()
					end
					if state.search_pattern then
						fs.reset_search(state, false)
					end
					fs._navigate_internal(state, parent_path, path_to_reveal, function()
						require("neo-tree.sources.common.commands").close_node(state)
					end, false)
				end,
				shrink_dir = function(state)
					local node = state.tree:get_node()
					if require("neo-tree.utils").is_expandable(node) then
						state.commands["toggle_directory"](state)
					else
						state.commands["close_node"](state)
					end
				end,
			},
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						-- auto close
						-- vim.cmd("Neotree close")
						-- OR
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
	end,
}

return plugin
