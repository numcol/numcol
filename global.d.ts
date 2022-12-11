export {}

declare global {
	interface Newable<T> extends Function {
		// eslint-disable-next-line @typescript-eslint/no-explicit-any
		new (...args: any[]): T
	}

	interface Abstract<T> extends Function {
		prototype: T
	}

	type Identifier<T> = Newable<T> | Abstract<T>
}
