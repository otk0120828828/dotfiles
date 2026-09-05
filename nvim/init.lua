vim.opt.termguicolors = true
vim.opt.background = "dark"

local transparent_groups = {
  "Normal",
  "NormalNC",
  "SignColumn",
  "EndOfBuffer",
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, {
    bg = "NONE",
  })
end
