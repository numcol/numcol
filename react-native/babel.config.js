module.exports = function (api) {
	api.cache(true)
	return {
		presets: ["babel-preset-expo"],
		plugins: [
			[
				"module-resolver",
				{
					alias: {
						// This needs to be mirrored in tsconfig.json
						"@numcol/ds": "./src/ds",
						"@numcol/screens": "./src/screens",
						"@numcol/i18n": "./src/i18n",
					},
					extensions: [".js", ".ios.js", ".android.js"],
				},
			],
		],
	}
}
