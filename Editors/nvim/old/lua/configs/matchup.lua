-- https://github.com/andymass/vim-matchup
local g = vim.g

g.matchup_enabled = true

g.matchup_matchparen_enabled = true
g.matchup_motion_enabled = true
g.matchup_text_obj_enabled = true
g.matchup_surround_enabled = true
g.matchup_transmute_enabled = true

g.matchup_delim_stopline = 1500
g.matchup_delim_noskips = false

g.matchup_matchparen_fallback = true
g.matchup_matchparen_singleton = false
g.matchup_matchparen_offscreen = { method = "status" }
g.matchup_matchparen_deferred = true
g.matchup_matchparen_deferred_show_delay = 300
g.matchup_matchparen_deferred_hide_delay = 700
g.matchup_matchparen_hi_surround_always = true

