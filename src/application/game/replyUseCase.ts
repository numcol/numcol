import { GameRepository } from "@numcol/domain"
import { Uuid } from "../../domain/crosscutting/uuid"
import { UseCase } from "../crosscutting/useCase"

interface ReplyUseCaseParams {
	gameId: string
	answerId: string
}

export class ReplyUseCase extends UseCase<ReplyUseCaseParams> {
	public constructor(private readonly gameRepository: GameRepository) {
		super()
	}

	protected async exec({
		gameId,
		answerId,
	}: ReplyUseCaseParams): Promise<void> {
		const game = await this.gameRepository.getById(Uuid.fromString(gameId))
		if (!game) {
			return
		}
		game.reply(Uuid.fromString(answerId))
		await this.gameRepository.save(game)
	}
}
