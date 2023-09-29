const { defineConfig } = require("eslint-define-config");

module.exports = defineConfig({
	extends: ["eslint:recommended", "plugin:unicorn/recommended", "prettier"],
	env: {
		amd: true,
		es6: true,
		node: true,
	},
	rules: {
		// eslint
		"prefer-const": "error",
		"no-unsafe-finally": "off",
		"no-useless-fallback-in-spread": "off",
		"no-console": ["error", { allow: ["warn", "error"] }],
		"no-unused-vars": ["error", { argsIgnorePattern: "^_" }],

		// eslint-plugin-unicorn
		"unicorn/no-null": "off",
		"unicorn/prefer-array-flat-map": "off",
		"unicorn/prevent-abbreviations": "off",
	},
});
