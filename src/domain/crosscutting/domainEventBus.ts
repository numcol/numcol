import { DomainEvent } from "./domainEvent"

type DomainEventHandler = (event: DomainEvent) => void

export class DomainEventBus {
	private static handlersMap = new Map<
		Identifier<DomainEvent>,
		Array<DomainEventHandler>
	>()

	public static registerHandler<T extends DomainEvent>(
		handler: (event: T) => void,
		identifier: Identifier<T>,
	): void {
		const currentHandlers = this.handlersMap.get(identifier) ?? []
		this.handlersMap.set(identifier, [
			...currentHandlers,
			handler as DomainEventHandler,
		])
	}

	public static clearHandlers(): void {
		this.handlersMap = new Map()
	}

	public static dispatchEvents(events: DomainEvent[]): void {
		events.forEach((event: DomainEvent) => DomainEventBus.dispatch(event))
	}

	private static dispatch(event: DomainEvent): void {
		const handlers = this.handlersMap.get(event.constructor)

		if (handlers) {
			for (const handler of handlers) {
				handler(event)
			}
		}
	}
}
