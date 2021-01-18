/** @type {import("@babel/core").TransformOptions} */
module.exports = {
	// https://babeljs.io/docs/en/next/options
	presets: [
		[
			"@babel/preset-env",
			{
				targets: {
					node: "current",
				},
			},
		],
	],

	plugins: [
		// https://github.com/tleunen/babel-plugin-module-resolver
		[
			"module-resolver",
			{
				root: ["./"],
				alias: {
					"@": "./source",
				},
			},
		],
	],

	sourceMaps: "both",
	sourceRoot: "./source",

	minified: false,
};
