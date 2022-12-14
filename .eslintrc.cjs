const commonForbiddenImportPatterns = [
	"**/../infrastructure/**/*",
	"**/../infrastructure",
	"**/../application/**/*",
	"**/../application",
	"**/../domain/**/*",
	"**/../domain",
	"**/../design-system/**/*",
	"**/../design-system",
]

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
				"@typescript-eslint/explicit-member-accessibility": "error",
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
				"react-hooks/exhaustive-deps": ["error"],
				"@typescript-eslint/no-shadow": ["error"],
			},
		},
		{
			files: ["src/design-system/**/*"],
			rules: {
				"@typescript-eslint/no-restricted-imports": [
					"error",
					{
						paths: [
							"@numcol/infra",
							"@numcol/ui",
							"@numcol/domain",
							"@numcol/ds",
						],
						patterns: [...commonForbiddenImportPatterns, "@react-navigation/*"],
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
							"@numcol/ui",
							"@numcol/ds",
							"@numcol/domain",
							"@numcol/app",
							"react",
							"react-native",
							"@react-navigation/*",
						],
						patterns: [...commonForbiddenImportPatterns],
					},
				],
			},
		},
		{
			files: ["src/ui/**/*"],
			rules: {
				"@typescript-eslint/no-restricted-imports": [
					"error",
					{
						paths: ["@numcol/infra", "@numcol/ui", "diod", "react-native-logs"],
						patterns: [...commonForbiddenImportPatterns, "expo-*"],
					},
				],
			},
		},
		{
			files: ["src/infrastructure/**/*"],
			rules: {
				"@typescript-eslint/no-restricted-imports": [
					"error",
					{
						paths: ["@numcol/infra"],
						patterns: [...commonForbiddenImportPatterns],
					},
				],
			},
		},
	],
}
