import { DomainEvent, DomainEventBus, DomainEventHandler } from "@numcol/domain"
import { useCallback, useEffect, useMemo, useRef } from "react"
import { useService } from "../providers/DependencyInjectionProvider"

export const useSubscribeTo = <T extends DomainEvent>(eventName: string) => {
	const handlerRef = useRef<((ev: T) => void) | null>(null)
	const domainEventBus = useService(DomainEventBus)

	const on = useCallback((handler: (ev: T) => void) => {
		handlerRef.current = handler
	}, [])

	const handler = useMemo<DomainEventHandler<T>>(
		() => ({
			subscribeTo: eventName,
			invoke: (ev) => {
				handlerRef.current?.(ev)
			},
		}),
		[eventName],
	)

	useEffect(() => {
		domainEventBus.registerHandler(handler)
		return () => {
			domainEventBus.unregisterHandler(handler)
		}
	}, [handler, domainEventBus])

	return { on }
}
