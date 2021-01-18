module.exports = {
	// https://jsdoc.app/about-configuring-jsdoc.html
	plugins: [],
	recurseDepth: 10,
	source: {
		include: ["./source"],
		includePattern: ".+\\.js$",
		exclude: [],
		excludePattern: "(^|\\/|\\\\)_",
	},
	sourceType: "module",
	tags: {
		allowUnknownTags: false,
		dictionaries: ["jsdoc", "closure"],
	},
	templates: {
		cleverLinks: false,
		monospaceLinks: false,
	},
	// https://jsdoc.app/about-commandline.html
	opts: {
		destination: "./documentation/",
		encoding: "utf8",
		recurse: true,
		readme: "./README.md",
		package: "./package.json",
	},
};
