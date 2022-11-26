/* eslint-disable no-console */
/* eslint-disable @typescript-eslint/no-explicit-any */
import { useCallback } from "react"

export const useLogger = (): {
	log: (message: string, data?: Record<string, any>) => void
	error: (error: Error, data?: Record<string, any>) => void
} => {
	const log = useCallback((message: string, data?: Record<string, any>) => {
		console.log(message, data)
	}, [])

	const error = useCallback((error: Error, data?: Record<string, any>) => {
		console.error(error, data)
	}, [])

	return { log, error }
}
