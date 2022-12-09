import { NumcolColor } from "./color"
import { NumcolNumber } from "./number"
import { Numcol } from "./numcol"
import { randomStringEnum } from "./randomGenerator"

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
			newAnswer = Answer.randomAnswer(this.id)
		} while (newAnswer.numcol.equals(this.numcol))

		return newAnswer
	}

	public static randomAnswer(id: number) {
		return new Answer(id, randomNumcol())
	}

	public static fromValues(
		id: number,
		color: NumcolColor,
		number: NumcolNumber,
	) {
		return new Answer(id, new Numcol(color, number))
	}
}

const randomNumcol = () => new Numcol(randomColor(), randomNumber())

const randomColor = () => randomStringEnum(NumcolColor)

const randomNumber = () => randomStringEnum(NumcolNumber)
