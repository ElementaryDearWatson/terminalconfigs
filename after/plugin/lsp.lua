local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Install and configure omnisharp
lsp.ensure_installed({
	'eslint',
	'omnisharp' , -- Ensure omnisharp is installed
})


-- Add any custom settings for omnisharp if needed
lsp.setup {
  servers = {
    omnisharp = {
      -- Add any custom settings here if required.
      -- For example, to set the path to the .NET SDK:
      -- cmd = {"/path/to/omnisharp", "--some-option"},  -- Replace with actual path
    },
  },
}


-- If you are using nvim-cmp, you need to add the following lines
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
lsp.setup_nvim_cmp({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- If you're using LuaSnip
        { name = 'buffer' },
        { name = 'path' },
    }),
    mapping = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
--no sign icons
lsp.set_preferences({
	sign_icons = { }
})

--setup nvim
lsp.setup_nvim_cmp({
	mappings = cmp_mappings
})

--Lsp on attach
lsp.on_attach(function(client, bufnr)
 local opts = { buffer = bufnr, remap = false}

 vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
 vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
 vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
 vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
 vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
 vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
 vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
 vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
 vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
 vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
 end)

