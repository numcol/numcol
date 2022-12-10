import { Answer } from "../answer"
import { Game } from "../game"

describe("Game", () => {
	let answers: Answer[]

	beforeEach(() => {
		answers = new Array(36)
			.fill(undefined)
			.map((_, i) => Answer.randomAnswer(i))
	})

	describe("creates a new game", () => {
		test("with an answerable question", () => {
			const game = Game.create(answers)
			expect(
				game.answers
					.map((answer) => answer.isCorrectFor(game.question))
					.filter((isCorrect) => isCorrect).length > 0,
			).toBe(true)
		})
	})

	describe("when answering a question", () => {
		let game: Game

		beforeEach(() => {
			game = Game.create(answers)
		})

		describe("if it is correct", () => {
			let correctAnswer: Answer

			beforeEach(() => {
				game = Game.create(answers)
				correctAnswer = game.answers.find(
					(answer) =>
						answer.numcol.color === game.question.color &&
						answer.numcol.number === game.question.number,
				) as Answer
			})

			test("increases game score by 10 points", () => {
				const newGame = game.reply(correctAnswer)
				expect(newGame.score - game.score).toBe(10)
			})

			test("changes the question with a new answerable question", () => {
				const newGame = game.reply(correctAnswer)
				expect(newGame.question).not.toEqual(game.question)
				expect(
					newGame.answers
						.map((answer) => answer.isCorrectFor(newGame.question))
						.filter((isCorrect) => isCorrect).length > 0,
				).toBe(true)
			})

			test("replaces the answer", () => {
				const newGame = game.reply(correctAnswer)
				expect(
					newGame.answers.find((answer) => answer.id === correctAnswer.id),
				).toBeDefined()
				expect(
					newGame.answers.find((answer) => answer.id === correctAnswer.id)
						?.numcol,
				).not.toEqual(correctAnswer.numcol)
			})
		})

		describe("if it is not correct", () => {
			let incorrectAnswer: Answer

			beforeEach(() => {
				game = Game.create(answers)
				incorrectAnswer = game.answers.find((answer) => {
					return (
						answer.numcol.color !== game.question.color ||
						answer.numcol.number !== game.question.number
					)
				}) as Answer
			})

			test("does not increase game score", () => {
				const newGame = game.reply(incorrectAnswer)
				expect(newGame.score - game.score).toBe(0)
			})

			test("does not change the question", () => {
				const newGame = game.reply(incorrectAnswer)
				expect(newGame.question).toEqual(game.question)
			})

			test("does not replace the answer", () => {
				const newGame = game.reply(incorrectAnswer)
				expect(
					newGame.answers.find((answer) => answer.id === incorrectAnswer.id),
				).toBeDefined()
				expect(
					newGame.answers.find((answer) => answer.id === incorrectAnswer.id)
						?.numcol,
				).toEqual(incorrectAnswer.numcol)
			})
		})
	})
})
