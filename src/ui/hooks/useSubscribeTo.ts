import { DomainEvent, DomainEventBus } from "@numcol/domain"
import { useCallback, useEffect, useRef } from "react"

export const useSubscribeTo = <T extends DomainEvent>(event: Identifier<T>) => {
	const handlerRef = useRef<((ev: T) => void) | null>(null)

	const on = useCallback((handler: (ev: T) => void) => {
		handlerRef.current = handler
	}, [])

	const handler = useCallback((ev: T) => {
		handlerRef.current?.(ev)
	}, [])

	useEffect(() => {
		DomainEventBus.registerHandler(handler, event)

		return () => {
			DomainEventBus.unregisterHandler(handler, event)
		}
	}, [handler, event])

	return { on }
}
