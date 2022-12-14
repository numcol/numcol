import { GameRepository } from "@numcol/domain"
import { Uuid } from "../../domain/crosscutting/uuid"
import { UseCase } from "../crosscutting/useCase"
import { GameDto } from "./dtos/GameDto"
import { mapGameDto } from "./dtos/gameDtoMapper"

interface GetGameUseCaseParams {
	gameId: string
}

export class GetGameUseCase extends UseCase<
	GetGameUseCaseParams,
	GameDto | undefined
> {
	public constructor(private readonly gameRepository: GameRepository) {
		super()
	}

	protected async exec({ gameId }: GetGameUseCaseParams) {
		const game = await this.gameRepository.getById(Uuid.fromString(gameId))
		return game ? mapGameDto(game) : undefined
	}
}
