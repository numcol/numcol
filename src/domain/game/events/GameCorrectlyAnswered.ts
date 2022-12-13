import { DomainEvent } from "../../crosscutting/domainEvent"
import { Uuid } from "../../crosscutting/uuid"
import { Numcol } from "../model/numcol"

export class GameCorrectlyAnswered implements DomainEvent {
	public readonly name = "game.correctly-answered"
	public readonly createdAt = new Date()

	public constructor(
		public readonly aggregateId: Uuid,
		public readonly answerId: Uuid,
		public readonly newNumcol: Numcol,
		public readonly newQUestion: Numcol,
	) {}
}
