import { Game } from "./game"

export abstract class GameFactory {
	abstract create(): Game
}
