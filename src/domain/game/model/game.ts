import { AggregateRoot } from "../../crosscutting/aggregateRoot"
import { DomainError } from "../../crosscutting/domainError"
import { Uuid } from "../../crosscutting/uuid"
import { GameCorrectlyAnswered } from "../events/gameCorrectlyAnswered"
import { GameCreated } from "../events/gameCreated"
import { GameWronglyAnswered } from "../events/gameWronglyAnswered"
import { Answer } from "./answer"
import { Numcol } from "./numcol"
import { randomItem } from "./randomGenerator"

const scoreIncreaseByCorrectAnswer = 10

export class Game extends AggregateRoot {
	private constructor(
		public readonly id: Uuid,
		private _answers: Answer[],
		private _question: Numcol,
		private _score: number,
	) {
		super()
	}

	public get answers(): Answer[] {
		return this._answers
	}

	public get question(): Numcol {
		return this._question
	}

	public get score(): number {
		return this._score
	}

	public static create(id: Uuid): Game {
		const answers = randomAnswers(id)
		const game = new Game(id, answers, randomQuestion(answers), 0)
		game.triggerEvent(new GameCreated(game.id.id))
		return game
	}

	public reply(answerId: Uuid): void {
		const answer = this.answers.find((a) => a.id.equals(answerId))
		if (!answer) {
			throw DomainError.cause("Answer do not exists")
		}

		if (answer?.isCorrectFor(this.question)) {
			this._score = this.score + scoreIncreaseByCorrectAnswer
			answer.renew()
			this.renewQuestion()
			this.triggerEvent(
				new GameCorrectlyAnswered(
					this.id.id,
					answer.id.id,
					answer.numcol,
					this.question,
					this.score,
				),
			)
			return
		}

		this.triggerEvent(
			new GameWronglyAnswered(this.id.id, answer.id.id, answer.numcol),
		)
	}

	private renewQuestion(): void {
		let newQuestion: Numcol
		do {
			newQuestion = randomQuestion(this.answers)
		} while (newQuestion.equals(this.question))

		this._question = newQuestion
	}
}

const randomQuestion = (answers: Answer[]) => randomItem(answers).numcol
const randomAnswers = (gameId: Uuid) =>
	new Array(36)
		.fill(undefined)
		.map((_, i) => Answer.create(Uuid.fromString(`${gameId.id}-${i}`)))
