local cmd = vim.cmd
local fn = vim.fn

cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")

if not present then
    local packer_path = "/site/pack/packer/opt/packer.nvim"
    local packer_dir = fn.stdpath("data") .. packer_path
    local packer_git = "https://github.com/wbthomason/packer.nvim"

    print("Cloning packer from: " .. packer_git)

    -- Remove the dir before cloning
    fn.delete(packer_dir, "rf")
    fn.system({ "git", "clone", packer_git, "--depth", "20", packer_dir })

    cmd("packadd packer.nvim")
    present, packer = pcall(require, "packer")

    if present then
        print("Packer cloned successfully.")
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_dir)
    end
end

return packer.init {
    display = {
        open_fn = function()
            return require("packer/util").float { border = "single" }
        end,
    },
    git = {
        clone_timeout = 600, -- Timeout, in seconds, for git clones
    },
}
