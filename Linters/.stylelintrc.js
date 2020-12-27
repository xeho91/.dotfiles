var rulesFrom_Stylelint = {
	// https://stylelint.io/user-guide/rules/list

	"no-duplicate-selectors": [true, { except: [":root"] }],
};

module.exports = {
	extends: [
		// https://github.com/constverum/stylelint-config-rational-order
		"stylelint-config-rational-order",

		// https://github.com/YozhikM/stylelint-a11y
		"stylelint-a11y/recommended",

		// https://github.com/darwintantuco/stylelint-8-point-grid
		"stylelint-8-point-grid",

		// https://github.com/prettier/stylelint-config-prettier
		"stylelint-config-prettier",
	],

	plugins: [
		// https://github.com/sh-waqar/stylelint-declaration-use-variable
		"stylelint-declaration-use-variable",

		// https://github.com/YozhikM/stylelint-a11y
		"stylelint-a11y",

		// https://github.com/darwintantuco/stylelint-8-point-grid
		"stylelint-8-point-grid",
	],

	rules: {
		...rulesFrom_Stylelint,
	},
};
