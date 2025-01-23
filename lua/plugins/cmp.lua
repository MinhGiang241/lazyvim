local cmp = {
  "hrsh7th/nvim-cmp",
  enabled = true,
  dependencies = {
    {
      "garymjr/nvim-snippets",
      opts = {
        friendly_snippets = true,
      },
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  },
  opts = function(_, opts)
    opts.snippet = {
      expand = function(item)
        return LazyVim.cmp.expand(item.body)
      end,
    }
    if LazyVim.has("nvim-snippets") then
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "snippets" })
    end
  end,
}

return { cmp }
