local theme = "tokyonight"

local M = {
	tokyonight = {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				on_colors = function(colors)
					colors.bg_dark = "#101317"
					-- colors.bg = "#15161F"
					colors.bg = "#1a1b26"
					-- colors.bg = "#101317"
					colors.bg_highlight = "#212231"
					colors.bg_light = "#2a2d3f"
					colors.terminal_black = "#414868"
					colors.fg = "#c0caf5"
					colors.fg_dark = "#a9b1d6"
					colors.fg_gutter = "#3b4261"
					colors.dark3 = "#545c7e"
					colors.comment = "#565f89"
					colors.dark5 = "#737aa2"
					colors.blue0 = "#3d59a1"
					colors.blue = "#7aa2f7"
					colors.cyan = "#7dcfff"
					colors.blue1 = "#2ac3de"
					colors.blue2 = "#0db9d7"
					colors.blue5 = "#89ddff"
					colors.blue6 = "#b4f9f8"
					colors.blue7 = "#394b70"
					colors.magenta = "#bb9af7"
					colors.magenta2 = "#ff007c"
					colors.purple = "#9d7cd8"
					colors.orange = "#ff9e64"
					colors.yellow = "#e0af68"
					colors.yellow2 = "#7E6039"
					colors.green = "#9ece6a"
					colors.green1 = "#73daca"
					colors.green2 = "#41a6b5"
					colors.teal = "#1abc9c"
					colors.red = "#f7768e"
					colors.red1 = "#db4b4b"

					-- colors.green = "#D6C8A7"
					-- colors.green = "#7ae582"
					colors.green = "#86E996"
					colors.purple = "#ef7a85"
					colors.magenta = "#9381ff"
				end,
				on_highlights = function(H, C)
					H.NvimTreeNormal = { bg = C.bg }
					H.NvimTreeNormalNC = { bg = C.bg }
					H.NvimTreeWinSeparator = { fg = C.bg_dark, bg = C.bg }
					H.DashboardMruTitle = { fg = C.orange, bold = true }
					H.DashboardProjectTitle = { fg = C.orange, bold = true }
					H.DashboardProjectIcon = { fg = C.magenta, bold = true }
					H.SagaNormal = { bg = C.bg }
					H.SagaBorder = { bg = C.bg, fg = C.orange }
					H.SpecialCmpBorder = { bg = C.bg }
					H.Pmenu = { bg = C.bg }
					H.LeapBackdrop = {}
					H.LeapLabelPrimary = { bg = C.bg_dark, fg = C.red1 }
					H.LeapLabelSecondary = { bg = C.bg_dark, fg = C.red1 }
					H.IndentBlanklineContextChar = { fg = C.fg_gutter }
					H.TelescopePromptNormal = { bg = C.bg_dark }
					-- H.TelescopePromptTitle = { fg = C.bg_dark, bg = C.magenta }
					-- H.TelescopePromptBorder = { fg = C.bg_dark, bg = C.bg_dark }
					-- H.TelescopePreviewTitle = { fg = C.bg_dark, bg = C.magenta }
					H.TelescopeSelection = { bg = C.fg_gutter }
					H.TelescopeBorder = { fg = C.magenta, bg = C.bg_dark }
					H.NeoTreeTitleBar = { fg = C.bg_dark, bg = C.magenta }
					H.NeoTreeFloatBorder = { fg = C.magenta, bg = C.bg_dark }
					-- H.NeoTreeGitModified = { fg = C.yellow, bold = true }
					H.NeoTreeGitUntracked = { fg = C.green, bold = true }
					-- H.GitSignsAdd = { fg = C.green }
					-- H.GitSignsChange = { fg = C.yellow2 }
					-- H.GitSignsDelete
					H.IlluminatedWordText = { bg = C.bg_light }
					H.IlluminatedWordRead = { bg = C.bg_light }
					H.IlluminatedWordWrite = { bg = C.bg_light }
				end,
			})
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}

M.github = {
	"projekt0n/github-nvim-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("github-theme").setup({
			-- ...
		})

		vim.cmd("colorscheme github_dark_dimmed")
	end,
}

M.catppuccin = {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			-- transparent_background = true,
			integrations = {
				-- telescope = true,
				neotree = true,
				noice = true,
				mason = true,
				mini = true,
				telescope = {
					enabled = true,
					-- style = "nvchad"
				},
				lsp_trouble = true,
				which_key = true,
			},
			color_overrides = {
				mocha = {
					base = "#1a1b26",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

M.oxocarbon = {
	"nyoom-engineering/oxocarbon.nvim",
	lazy = false,
	config = function()
		vim.opt.background = "dark" -- set this to dark or light
		vim.cmd.colorscheme("oxocarbon")
	end,
}

M.nightfox = {
	"EdenEast/nightfox.nvim",
	lazy = false,

	config = function()
		-- local c = require("nightfox.palette").load("carbonfox")
		local colors = {
			-- bg = "#15161E",
			bg0 = "#16161e", -- Dark bg (status line and float)
			bg1 = "#1a1b26", -- Default bg
			bg2 = "#202230", -- Lighter bg (colorcolm folds)
			bg3 = "#25293A", -- Lighter bg (cursor line)
			bg4 = "#2C3041", -- Conceal, border fg

			fg3 = "#3b4261", -- Darker fg (line numbers, fold columns)
			comment = "#565f89",

			red = "#F24A6E",

			orange = "#ff9e64",
			yellow = "#ffba08",
			cyan = "#33B1FF",
			magenta = "#9770E6",

			sel0 = "#222639", -- Popup bg, visual selection bg
			sel1 = "#32344a", -- Popup sel bg, search bg
		}

		local groups = {
			TelescopeBorder = { fg = "palette.magenta", bg = "bg0" },
			TelescopeNormal = { bg = "bg0" },
			TelescopeTitle = { fg = "fg3" },

			TelescopePromptPrefix = { link = "TelescopeBorder" },
			TelescopeSelectionCaret = { link = "TelescopeBorder" },

			TelescopeSelection = { link = "CursorLine" },
			TelescopeMatching = { link = "Search" },
		}

		require("nightfox").setup({
			palettes = {
				carbonfox = colors,
			},
			groups = {
				carbonfox = groups,
			},
		})
		vim.cmd.colorscheme("carbonfox")
	end,
}

M.dracus = {
	"Mofiqul/dracula.nvim",
	lazy = false,
}

return M[theme]
