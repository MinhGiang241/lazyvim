return {
  "jake-stewart/multicursor.nvim",
  branch = "main",
  config = function()
    local mc = require("multicursor-nvim")

    -- 1. Đã sửa lỗi chính tả setetup -> setup
    mc.setup()

    local set = vim.keymap.set

    -- Thêm con trỏ lên/xuống (Normal / Visual mode)
    set({ "n", "v" }, "<C-Up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "v" }, "<C-Down>", function()
      mc.lineSkipCursor(1)
    end)
    set({ "n", "v" }, "<leader><Up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<leader><Down>", function()
      mc.lineAddCursor(1)
    end)

    -- Chọn từ dưới con trỏ (Giống Ctrl+D trong VS Code)
    set({ "n", "v" }, "<C-d>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "<leader>s", function()
      mc.matchSkipCursor(1)
    end)

    -- 2. Đã sửa phím <leader><Esc> thành <Esc> chuẩn để xóa sạch cursor & highlight
    set({ "n", "x" }, "<leader><Esc>", function()
      if mc.hasCursors() or not mc.cursorsEnabled() then
        mc.clearCursors()
        mc.enableCursors()
      end
      vim.cmd("nohlsearch")
      vim.fn.clearmatches()
    end)

    -- Tắt/Bật nhanh trạng thái hoạt động của các con trỏ phụ
    set("n", "<leader>m", mc.toggleCursor)

    -- Cấu hình Highlight Groups
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
