local M = {
	"neovim/nvim-lspconfig",
	-- lazy = false,
	event = { "BufReadPre" },
	cmd = { "LspInfo", "LspInstall", "LspStart", "Mason" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
}

function M.config()
	local lspconfig = require("lspconfig")
	local lsp_defaults = lspconfig.util.default_config
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	-- local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true
	-- capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		"force",
		lsp_defaults.capabilities,
		-- capabilities
		cmp_nvim_lsp.default_capabilities()
	)

	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "LSP actions",
		callback = function(event)
			local opts = { buffer = event.buf }

			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
			vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
			vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
			vim.keymap.set({ "n", "x", "i" }, "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			-- formating is done by conform
			-- vim.keymap.set({ "n", "x", "i" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
			vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

			vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
			vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
			vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		end,
	})

	-----------------
	-- Mason
	-----------------

	local mason_settings = {
		ui = {
			border = "none",
			icons = {
				package_pending = " ",
				package_installed = "󰄳 ",
				package_uninstalled = " 󰚌",
			},
		},
		log_level = vim.log.levels.INFO,
		max_concurrent_installers = 4,
	}

	local default_setup = function(server)
		lspconfig[server].setup({})
	end

	require("mason").setup(mason_settings)
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"tsserver",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"emmet_ls",
			"jsonls",
			"pyright",
		},
		handlers = {
			default_setup,
			svelte = function()
				lspconfig.svelte.setup({
					-- fix for svelte-language-server watcher change detection
					on_attach = function(client, bufnr)
						if client.name == "svelte" or vim.bo[bufnr].filetype == "svelte" then
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts", "*.svelte" },
								callback = function(ctx)
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
								end,
							})
						end
					end,
					settings = {
						svelte = {
							validate = true,
						},
					},
				})
			end,
			lua_ls = function()
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							-- hint = {
							-- 	enable = true,
							-- },
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
			cssls = function()
				lspconfig.cssls.setup({
					settings = {
						css = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							validate = true,
						},
						less = {
							validate = true,
						},
					},
				})
			end,
			tailwindcss = function()
				lspconfig.tailwindcss.setup({
					settings = {
						tailwindCSS = {
							validate = true,
							experimental = {
								classRegex = {
									-- Custom class name attributes (e.g. buttonClassName)
									{ [==[[a-zA-Z]*ClassName=["'`]([^"'`]+)["'`]]==] },
									-- cls, clsx
									-- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
									{
										[[clsx\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
										'"(.*?)"',
									},
									-- Tailwind Variants
									-- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
									{
										[[tv\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
										'"(.*?)"',
									},
									-- `styles` objects
									-- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
									{ [[styles =([^}]*)\}]], [==[["'`]([^"'`]*).*?["'`]]==] },
								},
							},
						},
					},
				})
			end,
		},
	})

	------------------
	-- Diagnostics
	----------------

	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "󰠠" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- virtual text
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "",
		},
		-- show signs
		signs = false,
		-- signs = {
		-- 	active = signs,
		-- },
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
			suffix = "",
		},
	}

	vim.diagnostic.config(config)

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })

	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- 	border = "rounded",
	-- })
end

return M
