import { DomainEvent } from "../../crosscutting/domainEvent"
import { NumcolColor } from "../model/color"
import { NumcolNumber } from "../model/number"

export class GameCorrectlyAnswered implements DomainEvent {
	public readonly name = "game.correctly-answered"
	public readonly createdAt = new Date()

	public constructor(
		public readonly aggregateId: string,
		public readonly answerId: string,
		public readonly newAnswerValue: {
			color: NumcolColor
			number: NumcolNumber
		},
		public readonly newQuestion: {
			color: NumcolColor
			number: NumcolNumber
		},
		public readonly score: number,
	) {}
}
