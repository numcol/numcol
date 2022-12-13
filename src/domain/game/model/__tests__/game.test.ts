import { Uuid } from "../../../crosscutting/uuid"
import { Answer } from "../answer"
import { Game } from "../game"

describe("Game", () => {
	describe("creates a new game", () => {
		test("with an answerable question", () => {
			const game = Game.create(Uuid.fromString("uuid"))
			expect(
				game.answers
					.map((answer) => answer.isCorrectFor(game.question))
					.filter((isCorrect) => isCorrect).length > 0,
			).toBe(true)
		})

		test("with zero score", () => {
			const game = Game.create(Uuid.fromString("uuid"))
			expect(game.score).toBe(0)
		})
	})

	describe("when answering a question", () => {
		let game: Game

		beforeEach(() => {
			game = Game.create(Uuid.fromString("uuid"))
		})

		describe("if it is correct", () => {
			let correctAnswer: Answer

			beforeEach(() => {
				game = Game.create(Uuid.fromString("uuid"))
				correctAnswer = game.answers.find(
					(answer) =>
						answer.numcol.color === game.question.color &&
						answer.numcol.number === game.question.number,
				) as Answer
			})

			test("increases game score by 10 points", () => {
				const prevScore = game.score
				game.reply(correctAnswer.id)

				expect(game.score - prevScore).toBe(10)
			})

			test("changes the question with a new answerable question", () => {
				const prevQuestion = game.question
				game.reply(correctAnswer.id)

				expect(game.question.equals(prevQuestion)).toBe(false)
				expect(
					game.answers
						.map((answer) => answer.isCorrectFor(game.question))
						.filter((isCorrect) => isCorrect).length > 0,
				).toBe(true)
			})

			test("replaces the answer", () => {
				const prevCorrectAnswerId = correctAnswer.id
				const prevCorrectAnswerValue = correctAnswer.numcol
				game.reply(correctAnswer.id)

				expect(
					// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
					game.answers
						.find((answer) => answer.id === prevCorrectAnswerId)!
						.numcol.equals(prevCorrectAnswerValue),
				).toBe(false)
			})
		})

		describe("if it is not correct", () => {
			let incorrectAnswer: Answer

			beforeEach(() => {
				game = Game.create(Uuid.fromString("uuid"))
				incorrectAnswer = game.answers.find((answer) => {
					return (
						answer.numcol.color !== game.question.color ||
						answer.numcol.number !== game.question.number
					)
				}) as Answer
			})

			test("does not increase game score", () => {
				const prevScore = game.score
				game.reply(incorrectAnswer.id)
				expect(game.score - prevScore).toBe(0)
			})

			test("does not change the question", () => {
				const prevQuestion = game.question
				game.reply(incorrectAnswer.id)
				expect(game.question.equals(prevQuestion)).toBe(true)
			})

			test("does not replace the answer", () => {
				const prevIncorrectAnswerId = incorrectAnswer.id
				const prevIncorrectAnswerValue = incorrectAnswer.numcol
				game.reply(incorrectAnswer.id)

				expect(
					// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
					game.answers
						.find((answer) => answer.id === prevIncorrectAnswerId)!
						.numcol.equals(prevIncorrectAnswerValue),
				).toBe(true)
			})
		})
	})
})
