require("mason").setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "marksman",
    "gopls",
    "rust_analyzer",
    "qmlls",
    "nixd",
    "bashls"
})

vim.lsp.config("qmlls", {
    cmd = { "qmlls6", "-E", "-I", "/usr/lib/qt6/qml" },
})

-- semantic_tokens.lua:65 "attempt to compare number with nil":
-- bazı server'lar (log'da en şüpheli: qmlls) bozuk token dizisi
-- (uzunluk % 5 != 0) gönderiyor, Neovim 0.12.5 guard koymadığı için
-- modifiers_from_number(data[i+4]) içinde patlıyor.
-- Treesitter zaten highlight yaptığı için qmlls'te kapatmak kayıp değil.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "qmlls" then
            vim.lsp.semantic_tokens.enable(false, { bufnr = args.buf, client_id = client.id })
        end
    end,
})

vim.lsp.config("nixd", {
    cmd = {"nixd"};
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> {}",
            },
            formatting = {
                command = {"alejandra"},
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake (builtins.toString ./. )).nixosConfigurations.nixosBTW.options',
                },
                ["home-manager"] = {
                    expr = '(builtins.getFlake (builtins.toString ./. )).nixosConfigurations.nixosBTW.options.home-manager.users.type.getSubOptions []',
                },
            },
        },
    },
})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.nix",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
