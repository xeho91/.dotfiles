local http = require("http")
local json = require("json")
local file = require("file")
local cmd = require("cmd")

local function map_os()
	local os = RUNTIME.osType
	if os == "darwin" then
		return "macos"
	end

	return os
end

local function map_arch()
	local arch = RUNTIME.archType
	if arch == "amd64" then
		return "x64"
	elseif arch == "arm64" then
		return "arm64"
	end
	error("unsupported architecture: " .. tostring(arch))
end

-- Each product knows how to:
-- 1. list remote versions
-- 2. resolve the current platform to an artifact {version, url, hash, hash_algo, bin}
-- NOTE: Must stay in sync with backend_list_versions.lua
local PRODUCTS = {
	["pass-cli"] = {
		manifest = "https://proton.me/download/pass-cli/versions.json",
		resolve = function(manifest, os, arch, requested)
			local v = manifest.passCliVersions
			if requested ~= nil and requested ~= "latest" and requested ~= v.version then
				error(
					"requested version "
						.. requested
						.. " not found (latest is "
						.. v.version
						.. ")"
				)
			end

			local pass_arch = (arch == "x64") and "x86_64" or "aarch64"

			local rec = v.urls[os] and v.urls[os][pass_arch]
			if rec == nil then
				error("no binary for " .. os .. "/" .. pass_arch)
			end

			return {
				version = v.version,
				url = rec.url,
				hash = rec.hash,
				hash_algo = "sha256",
				bin = "pass-cli",
			}
		end,
	},

	["drive-cli"] = {
		manifest = "https://proton.me/download/drive/cli/version.json",
		resolve = function(manifest, os, arch, requested)
			local rel = manifest.Releases[1]
			if requested ~= nil and requested ~= "latest" and requested ~= rel.Version then
				error(
					"requested version "
						.. requested
						.. " not found (latest is "
						.. rel.Version
						.. ")"
				)
			end

			local want = os .. "/" .. arch
			for _, f in ipairs(rel.Files) do
				if f.Platform == want then
					return {
						version = rel.Version,
						url = f.Url,
						hash = f.Sha512CheckSum,
						hash_algo = "sha512",
						bin = (os == "windows") and "proton-drive.exe" or "proton-drive",
					}
				end
			end
			error("no binary for " .. want)
		end,
	},
}

local function get_product(tool)
	local p = PRODUCTS[tool]
	if p == nil then
		error("unsupported tool: " .. tostring(tool))
	end
	return p
end

local function fetch_manifest(p)
	local resp, err = http.get({ url = p.manifest })
	if err ~= nil then
		error("failed to fetch " .. p.manifest .. ": " .. tostring(err))
	end
	if resp.status_code ~= 200 then
		error("manifest " .. p.manifest .. " returned HTTP " .. resp.status_code)
	end

	local ok, manifest = pcall(json.decode, resp.body)
	if not ok or manifest == nil then
		error("failed to parse manifest " .. p.manifest)
	end

	return manifest
end

local function verify_hash(dest, algo, expected)
	if expected == nil or expected == "" then
		return
	end

	local sum_cmd = (algo == "sha512") and "shasum -a 512" or "shasum -a 256"

	local actual = cmd.exec(sum_cmd .. " " .. dest):match("^(%x+)")
	if actual == nil or string.lower(actual) ~= string.lower(expected) then
		error(algo .. " mismatch: expected " .. expected .. ", got " .. tostring(actual))
	end
end

function PLUGIN:BackendInstall(ctx)
	local p = get_product(ctx.tool)
	local manifest = fetch_manifest(p)
	local artifact = p.resolve(manifest, map_os(), map_arch(), ctx.version)

	local bin_dir = file.join_path(ctx.install_path, "bin")
	local dest = file.join_path(bin_dir, artifact.bin):gsub("\\", "/")
	cmd.exec("mkdir -p " .. dest:match("^(.*)/[^/]+$"))

	local err = http.download_file({ url = artifact.url }, dest)
	if err ~= nil then
		error("download failed: " .. tostring(err))
	end

	cmd.exec("chmod +x " .. dest)
	verify_hash(dest, artifact.hash_algo, artifact.hash)

	return {}
end
