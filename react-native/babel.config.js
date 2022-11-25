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
					},
					extensions: [".js", ".ios.js", ".android.js"],
				},
			],
		],
	}
}
