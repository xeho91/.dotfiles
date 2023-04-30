-- https://xplr.dev/en/configuration

---@diagnostic disable
version = "0.21.1"
local xplr = xplr
---@diagnostic enable

local home = os.getenv("HOME")

-- Lua search path
package.path = home
    .. "/.config/xplr/plugins/?/init.lua;"
    .. home
    .. "/.config/xplr/plugins/?.lua;"
    .. package.path

-- Add `eval "$(luarocks path --lua-version 5.1)"` in your `.bashrc` or `.zshrc`.
-- Install packages with `luarocks install $name --local --lua-version 5.1`.
package.path = os.getenv("LUA_PATH") .. ";" .. package.path
package.cpath = os.getenv("LUA_CPATH") .. ";" .. package.cpath

-- Plugin Manager
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(
  string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path)
)

-- Plugins
xplr.config.modes.builtin.default.key_bindings.on_key.x = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

-- https://github.com/dtomvan/xpm.xplr
require("xpm").setup({
  auto_install = true,
  auto_cleanup = true,
  plugins = {
    -- https://github.com/dtomvan/xpm.xplr
    "dtomvan/xpm.xplr",

    -- {
    --   -- https://github.com/Junker/nuke.xplr
    --   name = "Junker/nuke.xplr",
    --   setup = function()
    --     require("nuke").setup({})
    --
    --     local key = xplr.config.modes.builtin.default.key_bindings.on_key
    --     key.v = {
    --       help = "nuke",
    --       messages = { "PopMode", { SwitchModeCustom = "nuke" } },
    --     }
    --   end,
    -- },

    -- "sayanarijit/dual-pane.xplr",
    -- "sayanarijit/registers.xplr",
    -- "sayanarijit/offline-docs.xplr",
    -- "sayanarijit/scp.xplr",

    -- {
    --   name = "sayanarijit/tri-pane.xplr",
    --   setup = function()
    --     require("tri-pane").setup({ as_default_layout = false })
    --   end,
    -- },

    -- Previewer implementation for xplr using suckless tabbed and nnn preview-tabbed
    -- "sayanarijit/preview-tabbed.xplr",

    -- Send files to running Neovim sessions using nvim-ctrl
    "sayanarijit/nvim-ctrl.xplr",

    -- The missing command mode for xplr
    {
      name = "sayanarijit/command-mode.xplr",
      setup = function()
        local m = require("command-mode")

        m.setup({
          mode = "default",
          key = ":",
          remap_action_mode_to = {
            mode = "default",
            key = ";",
          }
        })

        local help = m.silent_cmd("help", "show global help menu")(
          m.BashExec([[glow --pager $XPLR_PIPE_GLOBAL_HELP_MENU_OUT]])
        )

        local doc =
            m.silent_cmd("doc", "show docs")(m.BashExec([[glow /usr/share/doc/xplr]]))

        -- map `?` to command `help`
        help.bind("default", "?")

        -- map `ctrl-?` to command `help`
        doc.bind("default", "ctrl-?")
      end,
    },

    -- xplr icon theme
    "prncss-xyz/icons.xplr",

    -- A clean, distraction free xplr table UI
    "sayanarijit/zentable.xplr",

    -- trach-cli integration for xplr
    "sayanarijit/trash-cli.xplr",

    -- zoxide integration for xplr
    "sayanarijit/zoxide.xplr",

    -- dragon integration for xplr
    "sayanarijit/dragon.xplr",

    -- xclip based copy-paste integration for xplr
    -- "sayanarijit/xclip.xplr",

    -- type-to-nav port for xplr
    "sayanarijit/type-to-nav.xplr",

    -- xplr + xargs = POWER!
    "sayanarijit/xargs.xplr",

    -- Context switch for xplr
    "igorepst/context-switch.xplr",

    -- An interactive finder plugin to complement map.xplr
    "sayanarijit/find.xplr",

    -- Visually inspect and interactively execute batch commands using xplr
    "sayanarijit/map.xplr",

    -- dua-cli integration for xplr
    -- "sayanarijit/dua-cli.xplr",

    -- xplr wrapper for https://github.com/ouch-org/ouch
    "dtomvan/ouch.xplr",

    -- Adds (dev)icons to xplr.
    {
      "dtomvan/extra-icons.xplr",
      after = function()
        xplr.config.general.table.row.cols[1] = {
          format = "custom.icons_dtomvan_col_1",
        }
      end,
    },

    -- fzf integration for xplr
    {
      name = "sayanarijit/fzf.xplr",
      setup = function()
        require("fzf").setup({
          args = "--preview 'pistol {}'",
          recursive = true,
          enter_dir = true,
        })
      end,
    },

    -- Use this plugin to paste your files to paste.rs, and open/delete them later in fzf.
    {
      name = "dtomvan/paste-rs.xplr",
      setup = function()
        require("paste-rs").setup({
          db_path = home .. "/" .. "paste.rs.list",
        })
      end,
    },

    -- https://github.com/sayanarijit/qrcp.xplr
    {
      name = "sayanarijit/qrcp.xplr",
      setup = function()
        require("qrcp").setup({
          mode = "action",
          key = "Q",
          -- send_options = "-i wlp2s0",
          -- receive_options = "-i wlp2s0",
          -- send_options = "-i $(ip link show | awk '{print $2}' | grep ':$' | cut -d: -f1 | fzf)",
          -- receive_options = "-i $(ip link show | awk '{print $2}' | grep ':$' | cut -d: -f1 | fzf)",
        })
      end,
    },

    {
      -- https://github.com/dtomvan/term.xplr
      name = "dtomvan/term.xplr",
      setup = function()
        require "term".setup({
          mode = 'default',
          key = 'ctrl-n',
          send_focus = true,
          send_selection = false,
          exe = 'kitty',
          extra_term_args = '@launch --no-response --location=vsplit',
          extra_xplr_args = '',
        })
      end,
    },
  },
})

-- Custom Config
xplr.config.general.enable_mouse = true
xplr.config.general.show_hidden = true
xplr.config.general.enable_recover_mode = true
