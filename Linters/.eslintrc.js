/** @type {import("eslint/rules").ESLintRules} */
var rulesFromESLint = {
	// https://eslint.org/docs/rules

	indent: ["warn", "tab", { SwitchCase: 1 }],

	"max-len": [
		"error",
		{
			code: 100,
			tabWidth: 4,
			ignoreStrings: true,
			ignoreTemplateLiterals: true,
			ignoreUrls: true,
		},
	],

	quotes: ["warn", "double", { avoidEscape: true }],

	"no-console": ["error"],

	"no-alert": ["error"],

	"no-debugger": ["error"],

	"prefer-named-capture-group": ["error"],

	"func-names": ["error", "as-needed"],
};

var rulesFromPlugins = {
	// https://github.com/mysticatea/eslint-plugin-node#-rules
	"node/file-extension-in-import": ["error", "always"],

	// Let eslint-import-plugin deal with resolving modules
	"node/no-missing-import": "off",
	"node/no-missing-require": "off",

	"node/no-unsupported-features/es-syntax": ["error", { version: ">=12.0.0" }],

	// https://github.com/benmosher/eslint-plugin-import#rules

	// https://github.com/benmosher/eslint-plugin-import#rules
	"import/no-unresolved": ["error", { commonjs: true }],
};

/** @type {import("eslint/lib/shared/types").ConfigData} */
module.exports = {
	extends: [
		// https://github.com/eslint/eslint/blob/master/conf/eslint-recommended.js
		"eslint:recommended",
		// https://github.comdd/mysticatea/eslint-plugin-node/blob/master/lib/configs/recommended-module.js
		"plugin:node/recommended",
		// https://github.com/benmosher/eslint-plugin-import/blob/master/config/recommended.js
		"plugin:import/recommended",
		// https://github.com/nodesecurity/eslint-plugin-security/blob/master/index.js
		"plugin:security/recommended",
		// https://github.com/xjamundx/eslint-plugin-promise/blob/development/index.js
		"plugin:promise/recommended",
		// https://github.com/prettier/eslint-config-prettier
		"prettier",
	],

	parserOptions: {
		ecmaVersion: 2020,
		sourceType: "module",
	},

	plugins: [
		// https://github.com/mysticatea/eslint-plugin-node
		"node",
		// https: //github.com/benmosher/eslint-plugin-import
		"import",
		// https://github.com/nodesecurity/eslint-plugin-security
		"security",
		// https://github.com/xjamundx/eslint-plugin-promise
		"promise",
		// https://github.com/xjamundx/eslint-plugin-html
		"html",
	],

	env: {
		es2020: true,
		node: true,
	},

	rules: {
		...rulesFromESLint,
		...rulesFromPlugins,
	},
};
