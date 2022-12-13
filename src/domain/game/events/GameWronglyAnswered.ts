import { DomainEvent } from "../../crosscutting/domainEvent"
import { Uuid } from "../../crosscutting/uuid"

export class GameWronglyAnswered implements DomainEvent {
	public readonly name = "game.wrongly-answered"
	public readonly createdAt = new Date()

	public constructor(
		public readonly aggregateId: Uuid,
		public readonly answerId: Uuid,
	) {}
}
