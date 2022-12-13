export abstract class UseCase<TParams = void, TResponse = void> {
	public async invoke(p: TParams): Promise<TResponse> {
		return await this.exec(p)
	}

	protected abstract exec(p: TParams): Promise<TResponse>
}
