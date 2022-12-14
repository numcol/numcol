import { DomainEvent } from "../../crosscutting/domainEvent"
import { GameEventNames } from "./gameEventNames"

export class GameCreated implements DomainEvent {
	public readonly name = GameEventNames.GameCreated
	public readonly createdAt = new Date()

	public constructor(public readonly aggregateId: string) {}
}
