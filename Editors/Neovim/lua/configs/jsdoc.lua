-- https://github.com/heavenshell/vim-jsdoc
local vimp = require("vimp")

-- vimp.nmap("<C-d>", "<Plug>(jsdoc)")
vimp.nmap("<C-d>", "?function<CR><Cmd>nohlsearch<CR><Plug>(jsdoc)")

