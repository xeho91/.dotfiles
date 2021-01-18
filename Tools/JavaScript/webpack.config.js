var path = require("path");
var yargs = require("yargs");
var webpack = require("webpack");

// yargs config
yargs
	.option("environment", {
		alias: "env",
		describe: "Specify the environment for build",
		choices: ["development", "production"],
		demandOption:
			"Please specify the environment to which you want to build binary files from the CLI directory!",
	})
	.example(
		'pnpm build:CLI "development"',
		'Build the binary files for this CLI in "development" environment'
	)
	.version(false)
	.help().argv;

// Determine the environment set based on the flag passed to command,
// an argument after --environment or --env
const environment = yargs.argv.environment;

var directories = new (function getProjectDirectoriesPaths() {
	this.root = path.join(__dirname, "..");

	this.config = path.join(this.root, "config");
	this.binary = path.join(this.root, "binary");
	this.source = path.join(this.root, "source");
})();

var { CleanWebpackPlugin } = require("clean-webpack-plugin");
var nodeExternals = require("webpack-node-externals");

/** @type {import("webpack").Configuration} */
module.exports = {
	mode: environment,

	target: "node",

	// https://github.com/liady/webpack-node-externals
	externals: [nodeExternals()],

	entry: {
		lilly: path.join(directories.source, "index.js"),
	},

	output: {
		filename: "lilly.js",
		path: directories.binary,
	},

	// https://webpack.js.org/configuration/resolve/
	resolve: {
		// https://webpack.js.org/configuration/resolve/#resolvealias
		alias: {
			"@": directories.source,
		},
	},

	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: [
					/node_modules/,
					/tests/,
				],
				use: [
					{
						// https://webpack.js.org/loaders/babel-loader/
						loader: "babel-loader",
						options: {
							extends: path.join(
								directories.config,
								".babelrc.js"
							),
						},
					},
				],
			},
			{
				test: /.test\.js$/,
				exclude: /node_modules/,
				include: /tests/,
				use: [
					{
						// https://github.com/webpack-contrib/mocha-loader
						loader: "mocha-loader",
						options: {},
					},
				],
			},
		],
	},

	plugins: [
		new CleanWebpackPlugin({
			// https://github.com/johnagan/clean-webpack-plugin#options-and-defaults-optional
			verbose: true,
		}),

		new webpack.BannerPlugin({
			// https://webpack.js.org/plugins/banner-plugin/#options
			banner: "#!/usr/bin/env node",
			raw: true,
		}),
	],
};
