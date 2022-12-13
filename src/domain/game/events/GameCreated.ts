import { DomainEvent } from "../../crosscutting/domainEvent"
import { Uuid } from "../../crosscutting/uuid"

export class GameCreated implements DomainEvent {
	public readonly name = "game.created"
	public readonly createdAt = new Date()

	public constructor(public readonly aggregateId: Uuid) {}
}
