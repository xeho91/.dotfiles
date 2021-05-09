-- https://github.com/mads-hartmann/bash-language-server
return {
    cmd = { "bash-language-server", "start" },
    cmd_env = { GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)" },
    filetypes = { "sh" },
}
