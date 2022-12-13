import { Uuid } from "../../domain/crosscutting/uuid"
import { Game } from "../../domain/game"
import { GameRepository } from "../../domain/game/services/GameRepository"

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
