local present, grapple = pcall(require, "grapple")

if not present then
	return
end

-- https://github.com/cbochs/grapple.nvim
grapple.setup {}
