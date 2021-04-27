-- https://github.com/monaqa/dial.nvim

local map = require("utils").map
local dial = require("dial")

local opts = {silent = false, noremap = false}

map("n", "<C-a>", "<Plug>(dial-increment)", opts)
map("n", "<C-x>", "<Plug>(dial-decrement)", opts)
map("v", "<C-a>", "<Plug>(dial-increment)", opts)
map("v", "<C-x>", "<Plug>(dial-decrement)", opts)
map("v", "g<C-a>", "<Plug>(dial-increment-additional)", opts)
map("v", "g<C-x>", "<Plug>(dial-decrement-additional)", opts)

dial.augends["custom#boolean"] =
	dial.common.enum_cyclic {
	name = "boolean",
	strlist = {"true", "false"}
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
	"custom#boolean"
}

dial.config.searchlist = {
	normal = augends,
	visual = augends
}
