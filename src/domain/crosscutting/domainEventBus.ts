import { DomainEvent } from "./domainEvent"
import { DomainEventHandler } from "./domainEventHandler"

export abstract class DomainEventBus {
	public abstract registerHandler<T extends DomainEvent>(
		handler: DomainEventHandler<T>,
	): void

	public abstract unregisterHandler<T extends DomainEvent>(
		handler: DomainEventHandler<T>,
	): void

	public abstract dispatchEvents(events: DomainEvent[]): void
}
