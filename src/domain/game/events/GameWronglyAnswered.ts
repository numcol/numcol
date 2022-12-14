import { DomainEvent } from "../../crosscutting/domainEvent"
import { NumcolColor } from "../model/color"
import { NumcolNumber } from "../model/number"
import { GameEventNames } from "./gameEventNames"

export class GameWronglyAnswered implements DomainEvent {
	public readonly name = GameEventNames.GameWronglyAnswered
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
