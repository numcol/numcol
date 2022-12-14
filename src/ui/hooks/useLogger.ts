import { Logger } from "@numcol/app"
import { useEffect } from "react"
import { useService } from "../providers/DependencyInjectionProvider"

export const useLogger = (onRenderDebug?: string) => {
	const logger = useService(Logger)

	useEffect(() => {
		if (onRenderDebug) {
			logger.debug(onRenderDebug)
		}
	}, [logger, onRenderDebug])

	return logger
}
