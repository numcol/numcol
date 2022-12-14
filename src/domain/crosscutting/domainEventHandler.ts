import { DomainEvent } from "./domainEvent"
export interface DomainEventHandler<T extends DomainEvent> {
	subscribeTo: string
	invoke: (event: T) => void
}
