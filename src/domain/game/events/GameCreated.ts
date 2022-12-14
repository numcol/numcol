import { DomainEvent } from "../../crosscutting/domainEvent"

export class GameCreated implements DomainEvent {
	public readonly name = "game.created"
	public readonly createdAt = new Date()

	public constructor(public readonly aggregateId: string) {}
}
