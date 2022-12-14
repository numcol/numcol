import { Logger } from "@numcol/app"
import { DomainEvent, DomainEventBus, DomainEventHandler } from "@numcol/domain"
import EventEmitter from "eventemitter3"

export class EventEmitter3DomainEventBus implements DomainEventBus {
	private readonly emitter = new EventEmitter()

	public constructor(private readonly logger: Logger) {}

	public registerHandler<T extends DomainEvent>(
		handler: DomainEventHandler<T>,
	): void {
		this.logger.debug(
			`Handler ${handler.constructor.name} registered for event ${handler.subscribeTo}`,
		)
		this.emitter.on(handler.subscribeTo, handler.invoke)
		this.logger.debug(
			`Handler ${handler.constructor.name} registered for event ${handler.subscribeTo}`,
		)
	}

	public unregisterHandler<T extends DomainEvent>(
		handler: DomainEventHandler<T>,
	): void {
		this.emitter.removeListener(handler.subscribeTo, handler.invoke)
		this.logger.debug(
			`Handler ${handler.constructor.name} unregistered for event ${handler.subscribeTo}`,
		)
	}

	public dispatchEvents(events: DomainEvent[]): void {
		for (const event of events) {
			this.emitter.emit(event.name, event)
		}
	}
}
