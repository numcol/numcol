import { Answer, Game, GameFactory } from "@numcol/domain"

export class RandomGameFactory implements GameFactory {
	public create(): Game {
		const answers = new Array(36)
			.fill(undefined)
			.map((_, i) => Answer.randomAnswer(i))
		return Game.create(answers)
	}
}
