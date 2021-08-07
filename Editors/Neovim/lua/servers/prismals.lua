-- https://github.com/prisma/language-tools
local root_pattern = require("lspconfig/util").root_pattern

return {
    cmd = { "prisma-language-server", "--stdio" },
    filetypes = { "prisma" },
    root_dir = root_pattern(".git", "package.json"),
    settings = { prisma = { prismaFmtBinPath = "" } },
}
