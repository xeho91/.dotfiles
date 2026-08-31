local file = require("file")

function PLUGIN:BackendExecEnv(ctx)
	local bin_dir = file.join_path(ctx.install_path, "bin")
	return {
		env_vars = {
			{ key = "PATH", value = bin_dir },
		},
	}
end
