local is_ssh = vim.g.is_ssh

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',

  dependencies = (function()
    local deps = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    }

    if not is_ssh then
      table.insert(deps, 'saadparwaiz1/cmp_luasnip')

      table.insert(deps, {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        -- dependencies = { 'rafamadriz/friendly-snippets' },
      })
    end

    return deps
  end)(),
  config = function()
    local cmp = require 'cmp'

    -- load + set up luasnip only when it exists
    local luasnip
    if not is_ssh then
      luasnip = require 'luasnip'
      luasnip.config.setup {}
    else
      -- stub so cmp-mappings don’t error out under SSH
      luasnip = setmetatable({}, {
        __index = function() return function() return false end end,
      })
    end

    cmp.setup {
      -- Snippet expansion: disable completely in SSH
      snippet = is_ssh and nil or {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },

      completion = { completeopt = 'menu,menuone,noinsert' },

      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif not is_ssh and luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-g>'] = cmp.mapping({
          i = function() if cmp.visible() then cmp.abort() else cmp.complete() end end,
          c = function() if cmp.visible() then cmp.close() else cmp.complete() end end,
        }),
      }),

      sources = (function()
        local s = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'lazydev', group_index = 0 },
        }
        if not is_ssh then
          table.insert(s, { name = 'luasnip' })
          table.insert(s, { name = 'vimtex' })
        end
        return s
      end)(),
    }
  end,
}

