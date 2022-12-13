import { Game, GameRepository, Uuid } from "@numcol/domain"

export class InMemoryGameRepository extends GameRepository {
	private currentGame: Game | undefined

	public getById(id: Uuid): Promise<Game | undefined> {
		const game = this.currentGame?.id.equals(id) ? this.currentGame : undefined
		return Promise.resolve(game)
	}

	protected saveInternal(game: Game): Promise<void> {
		this.currentGame = game
		return Promise.resolve()
	}
}
