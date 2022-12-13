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
						"@numcol/ds": "./src/ui/ds",
						"@numcol/ui": "./src/ui/app",
						"@numcol/infra": "./src/infrastructure",
						"@numcol/domain": "./src/domain",
						"@numcol/app": "./src/application",
					},
					extensions: [".js", ".ios.js", ".android.js"],
				},
			],
		],
	}
}
