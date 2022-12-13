import { Uuid } from "./uuid"

export interface DomainEvent {
	name: string
	createdAt: Date
	aggregateId: Uuid
}
