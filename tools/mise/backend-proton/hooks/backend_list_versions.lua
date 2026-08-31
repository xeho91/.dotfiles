local http = require("http")
local json = require("json")

local PRODUCTS = {
	-- Schema: { passCliVersions = { version, urls = { <os> = { <arch> = {url, hash} } } } }
	["pass-cli"] = {
		manifest = "https://proton.me/download/pass-cli/versions.json",
		list_versions = function(manifest)
			return { manifest.passCliVersions.version }
		end,
	},

	-- Schema: { Releases = [ { Version, Files = [ ... ] } ] }
	["drive-cli"] = {
		manifest = "https://proton.me/download/drive/cli/version.json",
		list_versions = function(manifest)
			local out = {}
			for _, r in ipairs(manifest.Releases) do
				out[#out + 1] = r.Version
			end
			return out
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

function PLUGIN:BackendListVersions(ctx)
	local p = get_product(ctx.tool)

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

	return { versions = p.list_versions(manifest) }
end
