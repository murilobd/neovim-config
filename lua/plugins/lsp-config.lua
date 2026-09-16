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
			ensure_installed = { "astro", "lua_ls", "ts_ls" },
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- Astro's Mason package currently bundles TypeScript 7, which no longer
			-- ships the JavaScript SDK files required by astro-language-server.
			-- Prefer a compatible workspace SDK and fall back to the TypeScript SDK
			-- bundled with Mason's typescript-language-server package.
			local typescript = require("mason-lspconfig.typescript")
			local ts_install_dir = vim.fs.joinpath(
				vim.fn.stdpath("data"),
				"mason",
				"packages",
				"typescript-language-server"
			)

			vim.lsp.config("astro", {
				before_init = function(_, config)
					local tsdk, tsserver = typescript.resolve_tsdk(ts_install_dir, config.root_dir)

					config.init_options = config.init_options or {}
					config.init_options.typescript = config.init_options.typescript or {}
					config.init_options.typescript.tsdk = tsdk
					config.init_options.typescript.serverPath = tsserver
				end,
			})
		end,
		dependencies = {
			-- Ensures mason and lspconfig are ready in runtimepath first
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
