import { Logger } from "@numcol/app"

import { consoleTransport, logger } from "react-native-logs"

const config = {
	transport: consoleTransport,
	severity: __DEV__ ? "debug" : "error",
	levels: {
		debug: 0,
		info: 1,
		warn: 2,
		error: 3,
	},
	transportOptions: {
		colors: {
			info: "blueBright",
			warn: "yellowBright",
			error: "redBright",
		},
	},
}

const LOG = logger.createLogger<"debug" | "info" | "warn" | "error">(config)

export class ReactNativeLogger implements Logger {
	public debug(message: string | Record<string, unknown>): void {
		LOG.debug(message)
	}

	public info(message: string | Record<string, unknown>): void {
		LOG.info(message)
	}

	public warn(message: string | Record<string, unknown>): void {
		LOG.warn(message)
	}

	public error(error: Error | Record<string, unknown>): void {
		if (error instanceof Error) {
			LOG.error(error.message, {
				stack: error.stack,
				cause: error.cause,
				name: error.name,
			})
		} else {
			LOG.error(error)
		}
	}
}
