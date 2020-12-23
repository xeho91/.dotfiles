/** @type {import("@types/prettier").Options} */
module.exports = {
	// https://prettier.io/docs/en/options.html
	printWidth: 80,

	tabWidth: 4,
	useTabs: true,

	singleQuote: false,
	quoteProps: "consistent",

	semi: true,
	trailingComma: "es5",

	bracketSpacing: true,
	arrowParens: "always",

	rangeStart: 0,
	rangeEnd: Infinity,

	endOfLine: "lf",

	overrides: [
		{
			files: ["*.json", "*.md", "*.yaml", "*.yml"],
			options: {
				tabWidth: 2,
				useTabs: false,
			},
		},
	],
};
