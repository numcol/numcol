import { BaseRepository } from "../../crosscutting/repository"
import { Game } from "../model/game"

export abstract class GameRepository extends BaseRepository<Game> {}
