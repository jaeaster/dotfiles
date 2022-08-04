vim.g.catppuccin_flavour = 'macchiato' -- latte, frappe, macchiato, mocha
vim.g.tokyonight_style = 'storm' -- day, storm, night
local colorscheme = 'tokyonight'

if colorscheme == 'catppuccin' then
  local status_ok, catppuccin = pcall(require, 'catppuccin')
  if status_ok then
    catppuccin.setup()
  end
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end
