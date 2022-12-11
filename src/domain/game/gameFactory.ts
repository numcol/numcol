import { Game } from "./game"

export abstract class GameFactory {
	public abstract create(): Game
}
