import { Game, GameRepository } from "@numcol/domain"
import { Uuid } from "../../domain/crosscutting/uuid"
import { UseCase } from "../crosscutting/useCase"

interface CreateGameUseCaseParams {
	gameId: string
}

export class CreateGameUseCase extends UseCase<CreateGameUseCaseParams> {
	public constructor(private readonly gameRepository: GameRepository) {
		super()
	}

	protected async exec({ gameId }: CreateGameUseCaseParams): Promise<void> {
		const game = Game.create(Uuid.fromString(gameId))
		await this.gameRepository.save(game)
	}
}
