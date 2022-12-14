import { DomainEvent } from "../../crosscutting/domainEvent"
import { NumcolColor } from "../model/color"
import { NumcolNumber } from "../model/number"

export class GameWronglyAnswered implements DomainEvent {
	public readonly name = "game.wrongly-answered"
	public readonly createdAt = new Date()

	public constructor(
		public readonly aggregateId: string,
		public readonly answerId: string,
		public readonly answerValue: {
			color: NumcolColor
			number: NumcolNumber
		},
	) {}
}
