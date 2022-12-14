import { Uuid } from "../../../crosscutting/uuid"
import { GameCorrectlyAnswered } from "../../events/gameCorrectlyAnswered"
import { GameWronglyAnswered } from "../../events/gameWronglyAnswered"
import { Answer } from "../answer"
import { Game } from "../game"

describe("Game", () => {
	afterEach(() => {
		jest.useRealTimers()
	})

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

		test("and fires a domain event", () => {
			jest.useFakeTimers()
			jest.setSystemTime(new Date("2020-02-19T00:00:00.000Z"))

			const game = Game.create(Uuid.fromString("uuid"))
			expect(game.domainEvents.length).toBe(1)
			expect(game.domainEvents[0]).toEqual({
				name: "numcol.game.created",
				createdAt: new Date("2020-02-19T00:00:00.000Z"),
				aggregateId: "uuid",
			})
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

			test("triggers a domain event", () => {
				jest.useFakeTimers()
				jest.setSystemTime(new Date("2020-02-19T00:00:00.000Z"))

				game.reply(correctAnswer.id)
				expect(game.domainEvents.length).toBeGreaterThanOrEqual(1)
				const domainEvent = game.domainEvents.pop() as GameCorrectlyAnswered
				expect(domainEvent.name).toBe("numcol.game.correctly-answered")
				expect(domainEvent.createdAt.toISOString()).toBe(
					"2020-02-19T00:00:00.000Z",
				)
				expect(domainEvent.aggregateId).toBe("uuid")
				expect(domainEvent.answerId).toBe(correctAnswer.id.id)
				expect(domainEvent.newAnswerValue).toBeDefined()
				expect(domainEvent.newQuestion).toEqual(game.question)
				expect(domainEvent.score).toEqual(game.score)
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

			test("triggers a domain event", () => {
				jest.useFakeTimers()
				jest.setSystemTime(new Date("2020-02-19T00:00:00.000Z"))

				game.reply(incorrectAnswer.id)
				expect(game.domainEvents.length).toBeGreaterThanOrEqual(1)
				const domainEvent = game.domainEvents.pop() as GameWronglyAnswered
				expect(domainEvent.name).toBe("numcol.game.wrongly-answered")
				expect(domainEvent.createdAt.toISOString()).toBe(
					"2020-02-19T00:00:00.000Z",
				)
				expect(domainEvent.aggregateId).toBe("uuid")
				expect(domainEvent.answerId).toBe(incorrectAnswer.id.id)
				expect(domainEvent.answerValue).toEqual(incorrectAnswer.numcol)
			})
		})
	})
})
