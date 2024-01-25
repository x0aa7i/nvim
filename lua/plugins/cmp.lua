return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
	},

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local defaults = require("cmp.config.default")()

			local kind_icons = {
				Array = "",
				Boolean = "",
				-- Class = "",
				Class = "󰠱",
				-- Color = "",
				Color = "󰏘",
				Constant = "󰏿",
				-- Constant = "",
				-- Constant = "󰇽",
				Constructor = "",
				-- Constructor = "",
				-- Constructor = "",
				Enum = "",
				EnumMember = "",
				Event = "",
				-- Event = "",
				-- Field = "",
				Field = "",
				File = "󰈙",
				-- File = "",
				Folder = "󰉋",
				Function = "󰊕",
				-- Interface = "",
				Interface = "",
				Key = "",
				Keyword = "",
				-- Keyword = "󰌋",
				Method = "",
				Module = "",
				Namespace = "",
				Null = "󰟢",
				Number = "",
				Object = "",
				Operator = "",
				-- Operator = "󰆕",
				Package = "",
				Property = "󰜢",
				-- Property = "",
				Reference = "󰈇",
				-- Reference = "",
				-- Reference = "",
				-- Snippet = "",
				Snippet = "",
				-- Snippet = "󰁨",
				-- Snippet = "",
				String = "",
				-- Struct = "",
				Struct = "󰙅",
				Text = "",
				-- Text = "󰉿",
				TypeParameter = "",
				-- TypeParameter = "󰊄",
				Unit = "",
				-- Unit = "",
				-- Value = "",
				Value = "󰎠",
				-- Variable = "",
				Variable = "󰀫",
				-- Variable = "󰆧",
				Codeium = "󰚩",
				Copilot = "",
			}

			return {
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("comment")
					end
				end,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- for `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<c-k>"] = cmp.mapping.select_prev_item(),
					["<c-j>"] = cmp.mapping.select_next_item(),
					["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<c-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					-- accept currently selected item. if none selected, `select` first item.
					-- set `select` to `false` to only confirm explicitly selected items.
					["<cr>"] = cmp.mapping.confirm({ select = false }),
					-- jump forwards in snippet positions
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					-- fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- vim_item.kind = kind_icons[vim_item.kind]
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- this concatonates the icons with the name of the item kind
						vim_item.menu = ({
							-- nvim_lua = "",
							nvim_lsp = "",
							luasnip = "",
							buffer = "",
							path = "",
							emoji = "",
						})[entry.source.name]
						return vim_item
					end,
				},
				sources = {
					{ name = "codeium" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer", keyword_length = 2 },
					{ name = "path" },
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = true,
				},
				sorting = defaults.sorting,
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			-- insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end

			cmp.setup(opts)
		end,
	},
}
