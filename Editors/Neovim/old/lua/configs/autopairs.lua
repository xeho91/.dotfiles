-- https://github.com/windwp/nvim-autopairs
local exists_autopairs, autopairs = pcall(require, "nvim-autopairs")
local exists_completion, autopairs_completion =
    pcall(require, "nvim-autopairs/completion/compe")

if not (exists_autopairs or exists_completion) then
    return
else
    autopairs.setup()
    autopairs_completion.setup {
        map_cr = true,
        map_complete = true, -- insert () func completion
    }
end
