import { useEffect } from "react"
import { useService } from "../providers/DependencyInjectionProvider"
import { Logger } from "../services"

export const useLogger = (onRenderDebug?: string) => {
	const logger = useService(Logger)

	useEffect(() => {
		if (onRenderDebug) {
			logger.debug(onRenderDebug)
		}
	}, [logger, onRenderDebug])

	return logger
}
