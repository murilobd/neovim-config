return {
	-- 1. Core LSP Configuration Engine
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Create an Autocmd to configure shortcuts and features only when an LSP connects
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }

					-- Safely enable inlay hints for the current buffer
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					vim.diagnostic.show()
					-- Your custom keymaps
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},

	-- 2. Package Manager for external binaries
	{
		"mason-org/mason.nvim",
		opts = {
			firewall = {
				enabled = true,
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- 3. Automatic bridge installer (using the correct mason-org organization)
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			-- Installs your language servers automatically
			ensure_installed = { "lua_ls", "ts_ls" },
		},
		dependencies = {
			-- Ensures mason and lspconfig are ready in runtimepath first
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
