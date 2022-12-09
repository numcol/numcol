import { useCallback } from "react"

import * as FileSystem from "expo-file-system"
import { consoleTransport, fileAsyncTransport, logger } from "react-native-logs"

const config = {
	transport: __DEV__ ? consoleTransport : fileAsyncTransport,
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
		FS: FileSystem,
	},
}

const LOG = logger.createLogger<"debug" | "info" | "warn" | "error">(config)

type LogFunction = (message: string | Record<string, unknown>) => void
type LogErrorFunction = (error: Error | Record<string, unknown>) => void

export const useLogger = (): {
	debug: LogFunction
	info: LogFunction
	warn: LogFunction
	error: LogErrorFunction
} => {
	const debug = useCallback((message: string | Record<string, unknown>) => {
		LOG.debug(message)
	}, [])
	const info = useCallback((message: string | Record<string, unknown>) => {
		LOG.info(message)
	}, [])

	const warn = useCallback((message: string | Record<string, unknown>) => {
		LOG.warn(message)
	}, [])

	const error = useCallback((error: Error | Record<string, unknown>) => {
		if (error instanceof Error) {
			LOG.error(error.message, {
				stack: error.stack,
				cause: error.cause,
				name: error.name,
			})
		} else {
			LOG.warn(error)
		}
	}, [])

	return { debug, info, warn, error }
}
