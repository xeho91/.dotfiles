-- https://github.com/monaqa/dial.nvim
local vimp = require("vimp")
local dial = require("dial")

vimp.nmap("<C-a>", "<Plug>(dial-increment)")
vimp.nmap("<C-x>", "<Plug>(dial-decrement)")
vimp.vmap("<C-a>", "<Plug>(dial-increment)")
vimp.vmap("<C-x>", "<Plug>(dial-decrement)")
vimp.vmap("g<C-a>", "<Plug>(dial-increment-additional)")
vimp.vmap("g<C-x>", "<Plug>(dial-decrement-additional)")

dial.augends["custom#boolean"] = dial.common.enum_cyclic {
    name = "boolean",
    strlist = { "true", "false" },
}

local augends = {
    "number#decimal",
    "number#decimal#int",
    "number#decimal#fixed#zero",
    "number#decimal#fixed#space",
    "number#hex",
    "number#octal",
    "number#binary",
    "date#[%Y/%m/%d]",
    "date#[%m/%d]",
    "date#[%-m/%-d]",
    "date#[%Y-%m-%d]",
    "date#[%Y年%-m月%-d日]",
    "date#[%Y年%-m月%-d日(%ja)]",
    "date#[%H:%M:%S]",
    "date#[%H:%M]",
    "date#[%ja]",
    "date#[%jA]",
    "char#alph#small#word",
    "char#alph#capital#word",
    "char#alph#small#str",
    "char#alph#capital#str",
    "color#hex",
    "markup#markdown#header",
    "custom#boolean",
}

dial.config.searchlist = { normal = augends, visual = augends }

