-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/xeho91/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/xeho91/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/xeho91/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/xeho91/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/xeho91/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    after = { "limelight.vim" },
    commands = { "TZMinimalist", "TZFocus", "TZAtaraxis", "TZBottom", "TZTop", "TZLeft" },
    config = { "require('configs/truezen')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/TrueZen.nvim"
  },
  ["dashboard-nvim"] = {
    commands = { "Dashboard" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/dashboard-nvim"
  },
  ["dial.nvim"] = {
    config = { "require('configs/dial')" },
    keys = { { "", "<C-x>" }, { "", "<C-a>" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/dial.nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = { "require('configs/diffview')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["emmet-vim"] = {
    keys = { { "", "<C-y>" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["focus.nvim"] = {
    commands = { "ToggleFocus" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/focus.nvim"
  },
  ["foldsigns.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14foldsigns\frequire\0" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/foldsigns.nvim"
  },
  ["friendly-snippets"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    config = { "require('configs/statusline')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gesture.nvim"] = {
    config = { "require('configs/gesture')" },
    keys = { { "", "<LeftDrag>" }, { "", "<LeftRelease>" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/gesture.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('configs/git')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    commands = { "Glow" },
    loaded = false,
    needs_bufread = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/glow.nvim"
  },
  ["hop.nvim"] = {
    config = { "require('configs/hop')" },
    keys = { { "", "$" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('configs/indentline')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["jsonc.vim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/jsonc.vim"
  },
  ["limelight.vim"] = {
    load_after = {
      ["TrueZen.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["lsp-rooter.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lsp-rooter.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    config = { "require('configs/lua-dev')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim"
  },
  ["minimap.vim"] = {
    commands = { "Minimap" },
    config = { "require('configs/minimap')" },
    keys = { { "", "<F8>" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/minimap.vim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "require('configs/neogit')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["neomutt.vim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/neomutt.vim"
  },
  ["neoscroll.nvim"] = {
    config = { "require('configs/scrolling')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "require('configs/autopairs')" },
    load_after = {
      ["nvim-compe"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    config = { "require('configs/bufferline')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    commands = { "CommentToggle" },
    config = { "require('configs/commenting')" },
    keys = { { "", "gc" }, { "", "gcc" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-compe"] = {
    after = { "vim-vsnip", "nvim-autopairs" },
    after_files = { "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "require('configs/completion')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require('configs/lsp')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    commands = { "Luadev" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-luadev"
  },
  ["nvim-luapad"] = {
    commands = { "LuaPad" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-luapad"
  },
  ["nvim-peekup"] = {
    config = { "require('configs/peekup')" },
    keys = { { "", '""' } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-peekup"
  },
  ["nvim-revJ.lua"] = {
    config = { "require('configs/revj')" },
    keys = { { "", "<leader>J" }, { "", "<leader>j" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-revJ.lua"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { "require('configs/file_explorer')" },
    keys = { { "", "<F2>" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('configs/treesitter')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    loaded = false,
    needs_bufread = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["scrollbar.nvim"] = {
    config = { "require('configs/scrolling')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/scrollbar.nvim"
  },
  sniprun = {
    commands = { "SnipRun" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/sniprun"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require('configs/telescope')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "require('configs/todo_comments')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "require('configs/theme')" },
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["vim-browserslist"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-browserslist"
  },
  ["vim-dotenv"] = {
    commands = { "Dotenv" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-dotenv"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign" },
    config = { "require('configs/easy_align')" },
    keys = { { "", "ga" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-eunuch"] = {
    commands = { "Delete", "Unlink", "Move", "Rename", "Chmod", "Mkdir", "Cfind", "Clocate", "Lfind", "Llocate", "Wall", "SudoWrite", "SudoEdit" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-eunuch"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-jsdoc"] = {
    commands = { "JsDoc" },
    config = { "require('configs/jsdoc')" },
    keys = { { "", "<Leader>dt" } },
    loaded = false,
    needs_bufread = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-jsdoc"
  },
  ["vim-prisma"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-prisma"
  },
  ["vim-sandwich"] = {
    keys = { { "", "sa" }, { "", "sd" }, { "", "sr" } },
    loaded = false,
    needs_bufread = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-sensible"
  },
  ["vim-signature"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-strip-trailing-whitespace"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-strip-trailing-whitespace"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    after = { "vim-vsnip-integ" },
    load_after = {
      ["nvim-compe"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    load_after = {
      ["vim-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/start/vimpeccable"
  },
  ["which-key.nvim"] = {
    commands = { "WhichKey" },
    config = { "require('configs/cheatsheet')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/xeho91/.local/share/nvim/site/pack/packer/opt/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: dashboard-nvim
time([[Setup for dashboard-nvim]], true)
require('setups/dashboard')
time([[Setup for dashboard-nvim]], false)
-- Config for: foldsigns.nvim
time([[Config for foldsigns.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14foldsigns\frequire\0", "config", "foldsigns.nvim")
time([[Config for foldsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('configs/treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('configs/indentline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
require('configs/scrolling')
time([[Config for neoscroll.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
require('configs/statusline')
time([[Config for galaxyline.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
require('configs/todo_comments')
time([[Config for todo-comments.nvim]], false)
-- Config for: scrollbar.nvim
time([[Config for scrollbar.nvim]], true)
require('configs/scrolling')
time([[Config for scrollbar.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
require('configs/theme')
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
require('configs/bufferline')
time([[Config for nvim-bufferline.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require('configs/git')
time([[Config for gitsigns.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('configs/telescope')
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('configs/lsp')
time([[Config for nvim-lspconfig]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'glow.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file WhichKey lua require("packer.load")({'which-key.nvim'}, { cmd = "WhichKey", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dotenv lua require("packer.load")({'vim-dotenv'}, { cmd = "Dotenv", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZMinimalist lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZMinimalist", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZFocus lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZFocus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LuaPad lua require("packer.load")({'nvim-luapad'}, { cmd = "LuaPad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZBottom lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZBottom", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZTop lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZTop", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZLeft lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZLeft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Delete lua require("packer.load")({'vim-eunuch'}, { cmd = "Delete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Unlink lua require("packer.load")({'vim-eunuch'}, { cmd = "Unlink", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Move lua require("packer.load")({'vim-eunuch'}, { cmd = "Move", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Rename lua require("packer.load")({'vim-eunuch'}, { cmd = "Rename", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Chmod lua require("packer.load")({'vim-eunuch'}, { cmd = "Chmod", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Mkdir lua require("packer.load")({'vim-eunuch'}, { cmd = "Mkdir", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Cfind lua require("packer.load")({'vim-eunuch'}, { cmd = "Cfind", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Clocate lua require("packer.load")({'vim-eunuch'}, { cmd = "Clocate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Lfind lua require("packer.load")({'vim-eunuch'}, { cmd = "Lfind", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Llocate lua require("packer.load")({'vim-eunuch'}, { cmd = "Llocate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Wall lua require("packer.load")({'vim-eunuch'}, { cmd = "Wall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudoWrite lua require("packer.load")({'vim-eunuch'}, { cmd = "SudoWrite", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewToggleFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewToggleFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewFocusFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewFocusFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JsDoc lua require("packer.load")({'vim-jsdoc'}, { cmd = "JsDoc", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Minimap lua require("packer.load")({'minimap.vim'}, { cmd = "Minimap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ToggleFocus lua require("packer.load")({'focus.nvim'}, { cmd = "ToggleFocus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dashboard lua require("packer.load")({'dashboard-nvim'}, { cmd = "Dashboard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SudoEdit lua require("packer.load")({'vim-eunuch'}, { cmd = "SudoEdit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SnipRun lua require("packer.load")({'sniprun'}, { cmd = "SnipRun", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Luadev lua require("packer.load")({'nvim-luadev'}, { cmd = "Luadev", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CommentToggle lua require("packer.load")({'nvim-comment'}, { cmd = "CommentToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TZAtaraxis lua require("packer.load")({'TrueZen.nvim'}, { cmd = "TZAtaraxis", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <C-x> <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "<lt>C-x>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> $ <cmd>lua require("packer.load")({'hop.nvim'}, { keys = "$", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> "" <cmd>lua require("packer.load")({'nvim-peekup'}, { keys = "\"\"", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <LeftRelease> <cmd>lua require("packer.load")({'gesture.nvim'}, { keys = "<lt>LeftRelease>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <LeftDrag> <cmd>lua require("packer.load")({'gesture.nvim'}, { keys = "<lt>LeftDrag>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>J <cmd>lua require("packer.load")({'nvim-revJ.lua'}, { keys = "<lt>leader>J", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> sr <cmd>lua require("packer.load")({'vim-sandwich'}, { keys = "sr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> sd <cmd>lua require("packer.load")({'vim-sandwich'}, { keys = "sd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Leader>dt <cmd>lua require("packer.load")({'vim-jsdoc'}, { keys = "<lt>Leader>dt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F8> <cmd>lua require("packer.load")({'minimap.vim'}, { keys = "<lt>F8>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'nvim-comment'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> sa <cmd>lua require("packer.load")({'vim-sandwich'}, { keys = "sa", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>j <cmd>lua require("packer.load")({'nvim-revJ.lua'}, { keys = "<lt>leader>j", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ga <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "ga", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-a> <cmd>lua require("packer.load")({'dial.nvim'}, { keys = "<lt>C-a>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <F2> <cmd>lua require("packer.load")({'nvim-tree.lua'}, { keys = "<lt>F2>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-y> <cmd>lua require("packer.load")({'emmet-vim'}, { keys = "<lt>C-y>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'nvim-comment'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType svelte ++once lua require("packer.load")({'emmet-vim'}, { ft = "svelte" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'emmet-vim'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'packer.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-compe', 'friendly-snippets'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'dashboard-nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-tree.lua'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
