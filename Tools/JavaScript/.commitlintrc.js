/** @type {import("@commitlint/types").UserConfig} */
module.exports = {
	// https://commitlint.js.org/#/reference-configuration

	// https://github.com/conventional-changelog/commitlint/blob/master/%40commitlint/config-conventional/index.js
	extends: ["@commitlint/config-conventional"],

	// https://commitlint.js.org/#/reference-rules
	rules: {
		// Overriding to shorten the max lengths
		"header-max-length": [2, "always", 72],
		"body-max-line-length": [2, "always", 80],
		"footer-max-line-length": [2, "always", 80],
	},
};
