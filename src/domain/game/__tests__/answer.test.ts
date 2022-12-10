import { Answer } from "../answer"
import { NumcolColor } from "../color"
import { NumcolNumber } from "../number"
import { Numcol } from "../numcol"

describe("Answer", () => {
	it("detects if is correct for a given question", () => {
		const answer = new Answer(
			1,
			new Numcol(NumcolColor.Blue, NumcolNumber.Eight),
		)

		expect(
			answer.isCorrectFor(new Numcol(NumcolColor.Blue, NumcolNumber.Eight)),
		).toBe(true)
	})

	it("detects if is incorrect for a given question", () => {
		const answer1 = new Answer(
			1,
			new Numcol(NumcolColor.Red, NumcolNumber.Eight),
		)
		const answer2 = new Answer(
			1,
			new Numcol(NumcolColor.Blue, NumcolNumber.Seven),
		)

		expect(
			answer1.isCorrectFor(new Numcol(NumcolColor.Blue, NumcolNumber.Eight)),
		).toBe(false)
		expect(
			answer2.isCorrectFor(new Numcol(NumcolColor.Blue, NumcolNumber.Eight)),
		).toBe(false)
	})

	it("renews it self with a different value", () => {
		const answer = new Answer(
			1,
			new Numcol(NumcolColor.Red, NumcolNumber.Eight),
		)

		const newAnswer = answer.renew()
		expect(newAnswer.id).toEqual(answer.id)
		expect(
			newAnswer.numcol.color === answer.numcol.color &&
				newAnswer.numcol.number === answer.numcol.number,
		).toBe(false)
	})
})
