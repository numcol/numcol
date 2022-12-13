import { ValueObject } from "../../crosscutting/valueObject"
import { NumcolColor } from "./color"
import { NumcolNumber } from "./number"

export class Numcol implements ValueObject<Numcol> {
	public constructor(
		public readonly color: NumcolColor,
		public readonly number: NumcolNumber,
	) {}

	public equals(numcol: Numcol): boolean {
		return this.number === numcol.number && this.color === numcol.color
	}

	public toString(): string {
		return `${this.color}-${this.number}`
	}
}