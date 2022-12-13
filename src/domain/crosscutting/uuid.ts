import { ValueObject } from "./valueObject"

export class Uuid implements ValueObject<Uuid> {
	private constructor(public readonly id: string) {}

	public static fromString(id: string): Uuid {
		return new Uuid(id)
	}

	public equals(other: Uuid): boolean {
		return this.id === other.id
	}
}
