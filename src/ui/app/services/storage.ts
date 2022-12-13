export abstract class Storage {
	public abstract setItem: (key: string, value: string) => Promise<void>
	public abstract getItem: (key: string) => Promise<string | undefined>
}
