import { Numcol } from "./numcol"
import { randomAnswer } from "./randomGenerator"

export class Answer {
	public constructor(
		public readonly id: number,
		public readonly numcol: Numcol,
	) {}

	public isCorrectFor(question: Numcol): boolean {
		return this.numcol.equals(question)
	}

	public renew(): Answer {
		let newAnswer: Answer
		do {
			newAnswer = randomAnswer(this.id)
		} while (newAnswer.numcol.equals(this.numcol))

		return newAnswer
	}
}
