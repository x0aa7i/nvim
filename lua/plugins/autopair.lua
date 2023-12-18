return {
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	-- event = "VeryLazy",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("nvim-surround").setup({
	-- 			keymaps = {
	-- 				insert = "<C-o>s",
	-- 				insert_line = "<C-o>S",
	-- 				normal = "s",
	-- 				normal_cur = "ss",
	-- 				normal_line = "S",
	-- 				normal_cur_line = "SS",
	-- 				visual = "S",
	-- 				visual_line = "gS",
	-- 				delete = "ds",
	-- 				change = "cs",
	-- 				change_line = "cS",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "<leader>sa", -- Add surrounding in Normal and Visual modes
				delete = "<leader>sd", -- Delete surrounding
				find = "<leader>sf", -- Find surrounding (to the right)
				find_left = "<leader>sF", -- Find surrounding (to the left)
				highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
}
