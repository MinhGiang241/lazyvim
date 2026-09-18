local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  },
  config = function(_, opts)
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.opt.fillchars = {
      foldopen = "",
      foldclose = "",
      fold = " ",
      foldsep = " ",
    }

    -- Chỉ hiển thị v/> nếu dòng hiện tại là DÒNG BẮT ĐẦU của một khối gập
    vim.o.statuscolumn =
      '%= %l %s%{foldclosed(v:lnum) == v:lnum ? ">" : (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? "" : " ")} '

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("local_detach_ufo", { clear = true }),
      pattern = opts.filetype_exclude,
      callback = function()
        require("ufo").detach()
      end,
    })

    require("ufo").setup(opts)
  end,
}

return M
