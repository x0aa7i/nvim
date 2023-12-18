local M = {
	"hrsh7th/nvim-cmp",
	version = false,
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/cmp-nvim-lua",
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	-- insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	-- load friendly-snippets
	require("luasnip.loaders.from_vscode").lazy_load()
	-- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#add-snippets
	require("luasnip.loaders.from_snipmate").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

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

	cmp.setup({
		enabled = function()
			-- disable completion in comments
			local context = require("cmp.config.context")
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			--
			-- overwrite default up and down
			-- ["<Down>"] = cmp.mapping(function(fallback)
			-- 	cmp.close()
			-- 	fallback()
			-- end, { "i" }),
			-- ["<Up>"] = cmp.mapping(function(fallback)
			-- 	cmp.close()
			-- 	fallback()
			-- end, { "i" }),
			--
			-- ["<Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_next_item()
			-- 	elseif luasnip.expandable() then
			-- 		luasnip.expand()
			-- 	elseif luasnip.expand_or_jumpable() then
			-- 		luasnip.expand_or_jump()
			-- 	elseif check_backspace() then
			-- 		fallback()
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, {
			-- 	"i",
			-- 	"s",
			-- }),
			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_prev_item()
			-- 	elseif luasnip.jumpable(-1) then
			-- 		luasnip.jump(-1)
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, {
			-- 	"i",
			-- 	"s",
			-- }),
		}),
		formatting = {
			-- fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- vim_item.kind = kind_icons[vim_item.kind]
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
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
			{ name = "nvim_lsp", trigger_characters = { "-" } },
			-- { name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer", keyword_length = 1 },
			{ name = "path" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = true,
		},
	})
end

return M
