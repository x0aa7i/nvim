local colors = {
	bg = "#16161E",
	fg = "#99a1c6",
	yellow = "#e0af68",
	cyan = "#449dab",
	green = "#9ece6a",
	orange = "#ff9e64",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#7da6ff",
	red = "#f7768e",
}

local wide_view = function()
	return vim.fn.winwidth(0) > 80
end

local total_lines = function()
	return "󰦨 " .. vim.api.nvim_buf_line_count(0)
end

local indent = function()
	return "󰌒 " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function is_file_window()
	return vim.bo.buftype == ""
end

return {
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		lazy = true,
		event = { "VimEnter" },
		opts = {
			options = {
				icons_enabled = true,
				-- theme = 'tokyonight',
				-- component_separators = '|',
				component_separators = "",
				section_separators = "",
				-- disabled_filetypes = { "alpha" },
			},
			extensions = { "neo-tree", "lazy", "toggleterm" },
			sections = {
				lualine_a = {
					{ "mode", icon = { "" } },
				},
				lualine_b = {
					{
						"diagnostics",
						-- symbols = { error = " ", warn = " ", info = " " },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰠠 ', other = '󱤅 ' },
						color = { bg = colors.bg },
						-- diagnostics_color = {
						--   error = { fg = colors.red },
						--   warn = { fg = colors.yellow },
						--   info = { fg = colors.cyan },
						--   hint = { fg = colors.blue }
						-- }
					},
				},
				lualine_c = {
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = { left = 1, right = 0 },
						cond = is_file_window,
					},
					{
						"filename",
						path = 1,
						cond = is_file_window,
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							startup = "Startup",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
						},
					},
				},
				lualine_x = {
					{
						"diff",
						-- symbols = { added = " ", modified = " ", removed = " " },
            symbols = { added = ' ', modified = ' ', removed = ' ' },
						cond = wide_view,
						-- diff_color = {
						--   added = { fg = colors.green },
						--   modified = { fg = colors.orange },
						--   removed = { fg = colors.red },
						-- },
					},
					{ "branch", icon = " " },
					{ indent, color = { fg = colors.fg }, cond = is_file_window },
					{ total_lines, color = { fg = colors.fg }, cond = is_file_window },
					-- "filetype",
				},
				lualine_z = {
					{
						"location",
						cond = is_file_window,
						-- icon = { "", align = "left" },
					},
				},
				-- lualine_z = { { "datetime", style = " %R" } },
			},
		},
	},
}
