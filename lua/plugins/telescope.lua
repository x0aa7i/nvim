return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- event = "VeryLazy",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		"debugloop/telescope-undo.nvim",
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files in cwd" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find string in cwd" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
		{ "<leader>fc", "<cmd>Telescope buffers<cr>", desc = "Find open buffers" },
		{ "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Browse files" },
		{
			"<leader>f.",
			"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
			desc = "Browse path of the current buffer",
		},
		{ "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Find undo history" },
		{ "<leader>;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		-- { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
	},
	config = function()
		local telescope = require("telescope")
		local actions_layout = require("telescope.actions.layout")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_strategy = "flex", -- Flex layout swaps between `horizontal` and `vertical` strategies based on the window width
				layout_config = {
					vertical = {
						preview_height = 0.5,
					},
				},
				cycle_layout_list = { "horizontal", "vertical" },
				prompt_prefix = "   ",
				selection_caret = " ",
				path_display = { "smart" },
				file_ignore_patterns = { ".git/", "node_modules" },
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				winblend = 0,
				mappings = {
					i = { -- Insert Mode mapping
						["<C-Right>"] = actions_layout.cycle_layout_next, -- Cycle history next: CTRL + Right
						["<C-Left>"] = actions_layout.cycle_layout_prev, -- Cycle history previous: CTRL + Left
						["<C-j>"] = actions.move_selection_next, -- scroll the list with <c-j>
						["<C-k>"] = actions.move_selection_previous, -- scroll the list with <c-k>
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
					},
				},
			},
			pickers = {
				colorscheme = { enable_preview = true },
			},
			extentions = {
				file_browser = {
					-- theme = "tokyonight",
					depth = 1,
					auto_depth = false,
					hidden = { file_browser = true, folder_browser = true },
					hide_parent_dir = false,
					collapse_dirs = false,
					prompt_path = false,
					quiet = false,
					dir_icon = "󰉓 ",
					git_status = true,
				},
			},
		})
		telescope.load_extension("noice")
		telescope.load_extension("file_browser")
		telescope.load_extension("undo")
	end,
}
