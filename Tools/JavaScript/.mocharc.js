var path = require("path");

// Because we're using import/export in our tests,
// we need Babel to deal with it
require("@babel/register")({
	extends: path.resolve("config", ".babelrc.js"),
});

/** @type {import("mocha").MochaOptions} */
module.exports = {
	hideDiff: false,
	recursive: true,
};
