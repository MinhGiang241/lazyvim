return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function(_, opts)
    local logo = [[
  ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃  
  ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦

              ███╗   ██╗ █████╗ ███████╗██╗  ██╗    
              ████╗  ██║██╔══██╗██╔════╝██║  ██║    
              ██╔██╗ ██║███████║███████╗███████║    
              ██║╚██╗██║██╔══██║╚════██║██╔══██║    
              ██║ ╚████║██║  ██║███████║██║  ██║    
              ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    
                    [ ✿ @nash.truong ✿ ]                   

  ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ 
  ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ ❃ 

    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
