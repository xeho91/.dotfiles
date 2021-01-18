module.exports = {
	// https://github.com/okonet/lint-staged#lintstagedrc-example

	// Firstly, analyse the code with linters
	"*.js": "pnpm lint:js",
	"*.md": "pnpm lint:md",
	// After that:
	"*.(js|json|md)": [
		// 1. Check coding styles
		"pnpm check",
		// 2. Check spellings
		"pnpm lint:spell",
	],
};
