export class DomainError extends Error {
	private constructor(message: string, public readonly parentError?: Error) {
		super(message)

		this.name = this.constructor.name

		Error.captureStackTrace?.(this, this.constructor)
	}

	public static cause(message: string, err?: Error): DomainError {
		return new DomainError(message, err)
	}
}
