/** @type {import("stylelint").Config} */
const config = {
	extends: "@terminal-nerds/stylelint-config",
	rules: {
		"css-modules/css-variables": [
			true,
			{
				resolve: {
					extensions: [".css", ".scss"],
					/* extensions: exclude(STYLESHEETS_EXTENSIONS, [HAS_SASS && "sass", HAS_SASS && "scss"]).map( */
					/* 	(extension) => `.${extension}`, */
					/* ), */
					modules: ["node_modules", "src/components",  "src/features/styles"],
				},
			},
		],
	}
};

module.exports = config;
