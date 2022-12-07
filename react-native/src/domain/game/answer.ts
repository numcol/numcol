import { NumcolColor } from "./color"
import { NumcolNumber } from "./number"
import { Numcol } from "./numcol"
import { randomStringEnum } from "./randomGenerator"

export class Answer {
	public constructor(
		public readonly id: number,
		public readonly numcol: Numcol,
	) {}

	public get number(): number {
		return numbers[this.numcol.number]
	}

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
}

const randomNumcol = () => new Numcol(randomColor(), randomNumber())

const randomColor = () => randomStringEnum(NumcolColor)

const randomNumber = () => randomStringEnum(NumcolNumber)

const numbers: Record<NumcolNumber, number> = {
	[NumcolNumber.One]: 1,
	[NumcolNumber.Two]: 2,
	[NumcolNumber.Three]: 3,
	[NumcolNumber.Four]: 4,
	[NumcolNumber.Five]: 5,
	[NumcolNumber.Six]: 6,
	[NumcolNumber.Seven]: 7,
	[NumcolNumber.Eight]: 8,
	[NumcolNumber.Nine]: 9,
}
