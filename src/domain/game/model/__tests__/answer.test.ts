import { Uuid } from "../../../crosscutting/uuid"
import { Answer } from "../answer"
import { NumcolColor } from "../color"
import { NumcolNumber } from "../number"
import { Numcol } from "../numcol"
import { randomStringEnum } from "../randomGenerator"

describe("Answer", () => {
	it("detects if is correct for a given question", () => {
		const answer = Answer.create(Uuid.fromString("uuid"))

		expect(answer.isCorrectFor(generateQuestionAnswerableBy(answer))).toBe(true)
	})

	it("detects if is incorrect for a given question", () => {
		const answer = Answer.create(Uuid.fromString("uuid"))

		expect(answer.isCorrectFor(generateQuestionNotAnswerableBy(answer))).toBe(
			false,
		)
	})

	it("renews it self with a different value", () => {
		const answer = Answer.create(Uuid.fromString("uuid"))
		const answerColor = answer.numcol.color
		const answerNumber = answer.numcol.number

		answer.renew()

		expect(answer.id.id).toEqual("uuid")
		expect(
			answerColor === answer.numcol.color &&
				answerNumber === answer.numcol.number,
		).toBe(false)
	})
})

const generateQuestionAnswerableBy = (answer: Answer) => {
	return new Numcol(answer.numcol.color, answer.numcol.number)
}

const generateQuestionNotAnswerableBy = (answer: Answer) => {
	let question: Numcol
	do {
		question = new Numcol(
			randomStringEnum(NumcolColor),
			randomStringEnum(NumcolNumber),
		)
	} while (
		question.color === answer.numcol.color &&
		question.number === answer.numcol.number
	)
	return new Numcol(question.color, question.number)
}
