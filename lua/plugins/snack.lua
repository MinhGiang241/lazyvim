return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          exclude = {
            "**/.git/*",
            "**/node_modules/*",
            "**/.yarn/cache/*",
            "**/.yarn/releases/*",
            "**/.pnpm-store/*",
          },
        },
      },
    },
    explorer = {
      files = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            "bin",
          },
        },
      },
    },
  },
}
