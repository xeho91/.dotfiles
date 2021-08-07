-- load default options
require("options")

local modules = { "mappings", "commands", "plugins" }

local async
async = vim.loop.new_async(
            vim.schedule_wrap(
                function()
            for i = 1, #modules, 1 do
                local ok, response = xpcall(require, debug.traceback, modules[i])

                if not (ok) then
                    print("Error loading module: " .. modules[i])
                    print(response) -- print stack traceback of the error
                end
            end

            async:close()
        end
            )
        )

async:send()
