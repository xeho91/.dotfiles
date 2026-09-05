---@class Runtime
--- Injected by the vfox plugin runtime (mise)
--- @see crates/vfox/src/runtime.rs
---
---@field osType string -- darwin | linux | windows
---@field archType string -- amd64 | arm64
---@field envType string|nil -- libc env: "gnu"|"musl", nil on macos/windows
---@field version string
---@field pluginDirPath string

---@type Runtime
RUNTIME = nil
