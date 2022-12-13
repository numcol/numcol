import { Game, GameRepository } from "@numcol/domain"
import { Uuid } from "../../domain/crosscutting/uuid"
import { UseCase } from "../useCase"

interface GetGameUseCaseParams {
	gameId: string
}

export class GetGameUseCase extends UseCase<
	GetGameUseCaseParams,
	Game | undefined
> {
	public constructor(private readonly gameRepository: GameRepository) {
		super()
	}

	protected async exec({
		gameId,
	}: GetGameUseCaseParams): Promise<Game | undefined> {
		const game = await this.gameRepository.getById(Uuid.fromString(gameId))
		return game
	}
}
