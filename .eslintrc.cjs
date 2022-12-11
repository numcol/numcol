module.exports = {
	extends: [
		"eslint:recommended",
		"plugin:@typescript-eslint/recommended",
		"plugin:react/recommended",
		"plugin:react/jsx-runtime",
		"plugin:react-hooks/recommended",
		"prettier",
	],
	parser: "@typescript-eslint/parser",
	plugins: ["@typescript-eslint"],
	root: true,
	env: {
		node: true,
	},
	rules: {
		"no-console": ["error"],
	},
	settings: {
		react: {
			version: "detect",
		},
	},
	overrides: [
		{
			files: ["*.ts", "*.tsx"],
			parserOptions: {
				project: ["./tsconfig.json"],
			},
			rules: {
				"@typescript-eslint/no-floating-promises": [
					"error",
					{ ignoreVoid: true },
				],
				"@typescript-eslint/no-unused-vars": [
					"error",
					{
						argsIgnorePattern: "^_",
						destructuredArrayIgnorePattern: "^_",
					},
				],
			},
		},
		{
			files: ["src/ds/**/*"],
			rules: {
				"@typescript-eslint/no-restricted-imports": [
					"error",
					{
						paths: [
							"@numcol/infra",
							"@numcol/app",
							"@numcol/domain",
							"@numcol/ds",
						],
						patterns: [
							"**/infrastructure/**/*",
							"**/infrastructure",
							"**/app/**/*",
							"**/app",
							"**/domain/**/*",
							"**/domain",
							"**/ds/**/*",
							"**/ds",
						],
					},
				],
			},
		},
		{
			files: ["src/domain/**/*"],
			rules: {
				"@typescript-eslint/no-restricted-imports": [
					"error",
					{
						paths: [
							"@numcol/infra",
							"@numcol/app",
							"@numcol/ds",
							"@numcol/ds",
							"react",
							"react-native",
						],
						patterns: [
							"**/infrastructure/**/*",
							"**/infrastructure",
							"**/app/**/*",
							"**/app",
							"**/domain/**/*",
							"**/domain",
							"**/ds/**/*",
							"**/ds",
						],
					},
				],
			},
		},
	],
}
