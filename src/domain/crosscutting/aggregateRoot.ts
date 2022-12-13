import { DomainEvent } from "./domainEvent"

export abstract class AggregateRoot {
	private _domainEvents: DomainEvent[] = []

	public get domainEvents(): DomainEvent[] {
		return this._domainEvents
	}

	public clearEvents(): void {
		this._domainEvents.splice(0, this._domainEvents.length)
	}

	protected triggerEvent(domainEvent: DomainEvent): void {
		this._domainEvents.push(domainEvent)
	}
}
