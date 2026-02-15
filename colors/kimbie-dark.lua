-- Kimbie Dark+ (VSCode-softened) for Neovim
-- Save as: ~/.config/nvim/colors/kimbie-dark.lua
-- Reload with: :colorscheme kimbie-dark

if vim.g.colors_name then
  vim.cmd("highlight clear")
end
vim.g.colors_name = "kimbie-dark"

vim.opt.termguicolors = true
vim.opt.background = "dark"

----------------------------------------------------------------
-- Color Math Helpers (for VSCode-style softening)
----------------------------------------------------------------

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1,2), 16),
    g = tonumber(hex:sub(3,4), 16),
    b = tonumber(hex:sub(5,6), 16),
  }
end

local function rgb_to_hex(rgb)
  return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

local function blend(fg, bg, alpha)
  local fg_rgb = hex_to_rgb(fg)
  local bg_rgb = hex_to_rgb(bg)

  return rgb_to_hex({
    r = math.floor((alpha * fg_rgb.r) + ((1 - alpha) * bg_rgb.r)),
    g = math.floor((alpha * fg_rgb.g) + ((1 - alpha) * bg_rgb.g)),
    b = math.floor((alpha * fg_rgb.b) + ((1 - alpha) * bg_rgb.b)),
  })
end

----------------------------------------------------------------
-- Palette
----------------------------------------------------------------

local colors = {
  -- >>> MAIN BACKGROUND (edit this if you want)
  bg       = "#201800",  -- <<< BACKGROUND COLOR
  bg_light = "#2A2000",
  bg_dark  = "#161100",

  fg       = "#C2A383",
  fg_dim   = "#8B7355",

  kw       = "#98676A",
  variable = "#DC3958",
  func     = "#8AB1B0",
  constant = "#F79A32",
  string   = "#889B4A",
  embedded = "#088649",
  class    = "#F06431",
  regex    = "#7E602C",
  property = "#D3AF86",

  cursor       = "#D3AF86",
  linenr       = "#594822",
  cursorlinenr = "#F79A32",
  selection    = "#3D2E14",
  match        = "#F79A32",

  term_red     = "#DC3958",
  term_green   = "#889B4A",
  term_yellow  = "#F79A32",
  term_blue    = "#719190",
  term_magenta = "#7E5053",
  term_cyan    = "#418292",
}

----------------------------------------------------------------
-- GLOBAL SOFTNESS CONTROL
----------------------------------------------------------------
-- 1.0 = original colors
-- 0.85 = slightly softer
-- 0.75 = very VSCode-like
----------------------------------------------------------------

local softness = 0.85

for k, v in pairs(colors) do
  if type(v) == "string" and v:match("^#") and k ~= "bg" and k ~= "bg_light" and k ~= "bg_dark" then
    colors[k] = blend(v, colors.bg, softness)
  end
end

----------------------------------------------------------------
-- Highlight helper
----------------------------------------------------------------

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

----------------------------------------------------------------
-- UI
----------------------------------------------------------------

hl("Normal",        { fg = colors.fg, bg = colors.bg })
hl("NormalNC",      { fg = colors.fg, bg = colors.bg })
hl("NormalFloat",   { fg = colors.fg, bg = colors.bg })
hl("FloatBorder",   { fg = colors.bg_light, bg = colors.bg })
hl("WinSeparator",  { fg = colors.bg_light, bg = colors.bg })
hl("VertSplit",     { fg = colors.bg_light, bg = colors.bg })

hl("Cursor",        { fg = colors.bg, bg = colors.cursor })
hl("CursorLine",    { bg = colors.bg_light })
hl("CursorLineNr",  { fg = colors.cursorlinenr, bg = colors.bg, bold = true })

hl("LineNr",        { fg = colors.linenr, bg = colors.bg })
hl("SignColumn",    { fg = colors.fg_dim, bg = colors.bg })
hl("FoldColumn",    { fg = colors.fg_dim, bg = colors.bg })
hl("EndOfBuffer",   { fg = colors.bg, bg = colors.bg })
hl("NonText",       { fg = colors.bg_light, bg = colors.bg })

hl("Visual",        { bg = colors.selection })
hl("Search",        { fg = colors.bg, bg = colors.match })
hl("IncSearch",     { fg = colors.bg, bg = colors.term_yellow })
hl("MatchParen",    { fg = colors.bg, bg = colors.match })

hl("StatusLine",    { fg = colors.fg, bg = colors.bg_light })
hl("StatusLineNC",  { fg = colors.fg_dim, bg = colors.bg_light })

hl("Pmenu",         { fg = colors.fg, bg = colors.bg_light })
hl("PmenuSel",      { fg = colors.bg, bg = colors.term_yellow })

----------------------------------------------------------------
-- Classic Syntax
----------------------------------------------------------------

hl("Comment",       { fg = colors.fg_dim, italic = true })
hl("Todo",          { fg = colors.term_yellow, bold = true })

hl("Constant",      { fg = colors.constant })
hl("String",        { fg = colors.string })
hl("Character",     { fg = colors.string })
hl("Number",        { fg = colors.constant })
hl("Boolean",       { fg = colors.constant })

hl("Identifier",    { fg = colors.variable })
hl("Function",      { fg = colors.func })

hl("Statement",     { fg = colors.kw })
hl("Keyword",       { fg = colors.kw })
hl("Operator",      { fg = colors.kw })

hl("Type",          { fg = colors.class })
hl("Structure",     { fg = colors.class })

hl("Property",      { fg = colors.property })
hl("Field",         { fg = colors.property })

----------------------------------------------------------------
-- Treesitter
----------------------------------------------------------------

hl("@comment",              { fg = colors.fg_dim, italic = true })

hl("@keyword",              { fg = colors.kw })
hl("@keyword.function",     { fg = colors.kw })
hl("@keyword.return",       { fg = colors.kw })

hl("@variable",             { fg = colors.variable })
hl("@variable.parameter",   { fg = colors.kw })

hl("@function",             { fg = colors.func })
hl("@type",                 { fg = colors.class })
hl("@property",             { fg = colors.property })
hl("@string",               { fg = colors.string })
hl("@number",               { fg = colors.constant })
hl("@operator",             { fg = colors.kw })

----------------------------------------------------------------
-- LSP Semantic Tokens
----------------------------------------------------------------

hl("@lsp.type.parameter",   { fg = colors.kw })
hl("@lsp.type.variable",    { fg = colors.variable })
hl("@lsp.type.function",    { fg = colors.func })
hl("@lsp.type.type",        { fg = colors.class })
hl("@lsp.type.property",    { fg = colors.property })

----------------------------------------------------------------
-- Fix TypeScript JSDoc (@param, etc)
----------------------------------------------------------------

hl("Special",               { fg = colors.kw })
hl("typescriptDocNotation", { fg = colors.kw })

----------------------------------------------------------------
-- Terminal palette
----------------------------------------------------------------

vim.g.terminal_color_0  = colors.bg_dark
vim.g.terminal_color_1  = colors.term_red
vim.g.terminal_color_2  = colors.term_green
vim.g.terminal_color_3  = colors.term_yellow
vim.g.terminal_color_4  = colors.term_blue
vim.g.terminal_color_5  = colors.term_magenta
vim.g.terminal_color_6  = colors.term_cyan
vim.g.terminal_color_7  = colors.fg
