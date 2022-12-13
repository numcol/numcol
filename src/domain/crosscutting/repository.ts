import { AggregateRoot } from "./aggregateRoot"
import { DomainEventBus } from "./domainEventBus"
import { Uuid } from "./uuid"

export interface Repository<T extends AggregateRoot> {
	getById(id: Uuid): Promise<T | undefined>
	save(aggregate: T): Promise<void>
}

export abstract class BaseRepository<T extends AggregateRoot>
	implements Repository<T>
{
	public abstract getById(id: Uuid): Promise<T | undefined>
	public async save(aggregate: T): Promise<void> {
		try {
			await this.saveInternal(aggregate)
			DomainEventBus.dispatchEvents(aggregate.domainEvents)
		} finally {
			aggregate.clearEvents()
		}
	}

	protected abstract saveInternal(aggregate: T): Promise<void>
}
