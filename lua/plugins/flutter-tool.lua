return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  after = "mason-lspconfig.nvim",
  config = function()
    require("flutter-tools").setup({
      -- lsp = {
      --   skip_setup = { "dartls" },
      -- },
      widget_guides = {
        enabled = true,
      },
      debugger = {
        -- integrate with nvim dap + install dart code debugger
        enabled = true,
        run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |::help dap.set_exception_breakpoints()help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {},
        register_configurations = function(_)
          require("dap").adapters.dart = {
            type = "executable",
            command = "node",
            args = { "C:/Users/minhg/Downloads/Developments/Dart-Code/out/dist/debug.js", "flutter" },
          }

          require("dap").configurations.dart = {
            {
              type = "dart",
              request = "launch",
              name = "Launch flutter",
              dartSdkPath = "C:/Users/flutter/bin/cache/dart-sdk/",
              flutterSdkPath = "C:/Users/flutter",
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
            },
          }
          require("dap").set_log_level("DEBUG")
          -- require("dap").adapters.dart = {
          --   type = "executable",
          --   command = "node",
          --   args = { "C:\\Users\\minhg\\Dart-Code\\out\\dist\\debug.js", "flutter" }
          -- }
        end,
        flutter_path = "C:\\Users\\flutter\\bin\\flutter.bat", -- <-- this takes priority over the lookup
        flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        dev_log = {
          enabled = true,
          open_cmd = "tabedit", -- command to use to open the log buffer
        },
        dev_tools = {
          autostart = true, -- autostart devtools server if not detected
          auto_open_browser = true, -- Automatically opens devtools in the browser
        },
        outline = {
          open_cmd = "30vnew", -- command to use to open the outline buffer
          auto_open = false, -- if true this will open the outline automatically when it is first populated
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { "C:\\Users\\flutter" },
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
        },
        -- lsp = {
        --   color = {
        --     -- show the derived colours for dart variables
        --     enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        --     background = false, -- highlight the background
        --     background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
        --     foreground = false, -- highlight the foreground
        --     virtual_text = true, -- show the highlight using virtual text
        --     virtual_text_str = "■", -- the virtual text character to highlight
        --   },
        -- }
      },
    })
  end,
}
