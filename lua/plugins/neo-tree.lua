return {
	{
		-- NeoTree
		-- https://github.com/nvim-neo-tree/neo-tree.nvim
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "NeoTree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			-- { "<leader>e", "<cmd>Neotree toggle position=left<cr>", desc = "Explorer NeoTree (cwd)" },
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		opts = {
			-- close_if_last_window = true,
			window = {
				position = "float",
				width = 70,
				mappings = {
					-- ["<space>"] = "none",
					["<space>"] = {
						"toggle_node",
						nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_dotfiles = false,
					hide_hidden = false,
					hide_gitignored = false,
				},
				commands = {
					-- overwrite default 'delete' command to 'trash'.
					delete = function(state)
						local inputs = require("neo-tree.ui.inputs")
						local path = state.tree:get_node().path
						local msg = "Are you sure you want to trash " .. path
						inputs.confirm(msg, function(confirmed)
							if not confirmed then
								return
							end

							vim.fn.system({ "trash", vim.fn.fnameescape(path) })
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
					-- over write default 'delete_visual' command to 'trash' x n.
					delete_visual = function(state, selected_nodes)
						local inputs = require("neo-tree.ui.inputs")

						-- get table items count
						function GetTableLen(tbl)
							local len = 0
							for n in pairs(tbl) do
								len = len + 1
							end
							return len
						end

						local count = GetTableLen(selected_nodes)
						local msg = "Are you sure you want to trash " .. count .. " files ?"
						inputs.confirm(msg, function(confirmed)
							if not confirmed then
								return
							end
							for _, node in ipairs(selected_nodes) do
								vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
							end
							require("neo-tree.sources.manager").refresh(state.name)
						end)
					end,
				},
			},
		},
	},
}
