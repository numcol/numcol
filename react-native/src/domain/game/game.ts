import { Answer } from "./answer"
import { Numcol } from "./numcol"
import { randomAnswers, randomQuestion } from "./randomGenerator"

const scoreIncreaseByCorrectAnswer = 10

export class Game {
	private constructor(
		public readonly answers: Answer[],
		public readonly question: Numcol,
		public readonly score: number,
	) {}

	public static create(): Game {
		const answers = randomAnswers()
		return new Game(answers, randomQuestion(answers), 0)
	}

	public reply(answer: Answer): Game {
		if (answer.isCorrectFor(this.question)) {
			const newAnswers = this.newAnswers(answer)
			return new Game(
				newAnswers,
				this.newQuestion(newAnswers),
				this.score + scoreIncreaseByCorrectAnswer,
			)
		}

		return this
	}

	private newAnswers(toRenew: Answer): Answer[] {
		return this.answers.map((answer) =>
			answer.id === toRenew.id ? answer.renew() : answer,
		)
	}

	private newQuestion(newAnswers: Answer[]): Numcol {
		let newQuestion: Numcol
		do {
			newQuestion = randomQuestion(newAnswers)
		} while (newQuestion.equals(this.question))

		return newQuestion
	}
}
