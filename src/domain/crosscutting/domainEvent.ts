export interface DomainEvent {
	name: string
	createdAt: Date
	aggregateId: string
}
