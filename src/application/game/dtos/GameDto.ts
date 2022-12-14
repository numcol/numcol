import { AnswerDto } from "./AnswerDto"
import { NumcolDto } from "./NumcolDto"

export interface GameDto {
	readonly id: string
	readonly answers: ReadonlyArray<AnswerDto>
	readonly question: NumcolDto
	readonly score: number
}
