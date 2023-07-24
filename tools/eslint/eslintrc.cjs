/** @type {import("eslint").Linter.Config} */
const config = {
	extends: "@terminal-nerds/eslint-config",
	env: {
		browser: false,
		node: true,
	},
};

module.exports = config;
