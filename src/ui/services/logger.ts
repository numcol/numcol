export abstract class Logger {
	public abstract debug(message: string | Record<string, unknown>): void
	public abstract info(message: string | Record<string, unknown>): void
	public abstract warn(message: string | Record<string, unknown>): void
	public abstract error(error: Error | Record<string, unknown>): void
}
