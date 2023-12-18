return {
	-- color highlighter
	"NvChad/nvim-colorizer.lua",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("colorizer").setup({
			filetypes = {
				"*",
				cmp_docs = { always_update = true },
			},
			user_default_options = {
				names = false, -- "Name" codes like Blue
				rgb_fn = true,
				hsl_fn = true,
				css_fn = true,
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
			},
		})
	end,
}
