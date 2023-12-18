return {
	-- https://github.com/folke/noice.nvim
	{
		-- enabled = false,
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				-- disable hover and signature because of a conflict with zero_lsp
				-- hover = { enabled = false },
				-- signature = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
				-- {
				-- 	filter = {
				-- 		event = "msg_show",
				-- 		kind = "",
				-- 		find = "written",
				-- 	},
				-- 	opts = { skip = true },
				-- },
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				},
			},
			presets = {
				-- bottom_search = true, -- use a classic bottom cmdline for search
				-- command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			views = {
				cmdline_popup = {
					position = { row = 10, col = "50%" },
				},
				popupmenu = {
					position = { row = 13, col = "50%" },
					size = {
						width = 60,
						max_height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
			notify = {
				enabled = true,
				view = "notify",
				replace = true,
			},
		},
		-- stylua: ignore
		keys = {
			{
				"<S-Enter>",
				function() require("noice").redirect(vim.fn.getcmdline()) end,
				mode = "c",
				desc = "Redirect Cmdline"
			},
			{
				"<leader>nl",
				function() require("noice").cmd("last") end,
				desc = "Noice Last Message"
			},
			{
				"<leader>nh",
				function() require("noice").cmd("history") end,
				desc = "Noice History"
			},
			{ "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
			{
				"<leader>nd",
				function() require("noice").cmd("dismiss") end,
				desc = "Dismiss All"
			},
			-- {
			-- 	"<c-f>",
			-- 	function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
			-- 	silent = true,
			-- 	expr = true,
			-- 	desc = "Scroll forward",
			-- 	mode = { "i", "n", "s" }
			-- },
			-- {
			-- 	"<c-b>",
			-- 	function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
			-- 	silent = true,
			-- 	expr = true,
			-- 	desc = "Scroll backward",
			-- 	mode = { "i", "n", "s" }
			-- },
		},
	},
}
