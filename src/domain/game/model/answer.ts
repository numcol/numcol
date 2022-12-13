import { Uuid } from "../../crosscutting/uuid"
import { NumcolColor } from "./color"
import { NumcolNumber } from "./number"
import { Numcol } from "./numcol"
import { randomStringEnum } from "./randomGenerator"

export class Answer {
	private constructor(public readonly id: Uuid, private _numcol: Numcol) {}

	public get numcol(): Numcol {
		return this._numcol
	}

	public static create(id: Uuid) {
		return new Answer(id, randomNumcol())
	}

	public isCorrectFor(question: Numcol): boolean {
		return this.numcol.equals(question)
	}

	public renew(): void {
		let numcol: Numcol
		do {
			numcol = randomNumcol()
		} while (numcol.equals(this.numcol))

		this._numcol = numcol
	}
}

const randomNumcol = () => new Numcol(randomColor(), randomNumber())

const randomColor = () => randomStringEnum(NumcolColor)

const randomNumber = () => randomStringEnum(NumcolNumber)
