import { Game } from "../../../domain/game"
import { GameDto } from "./GameDto"

export const mapGameDto = ({
	id,
	score,
	question,
	answers,
}: Game): GameDto => ({
	id: id.id,
	score: score,
	question: {
		color: question.color,
		number: question.number,
	},
	answers: answers.map(({ id: answerId, numcol }) => ({
		id: answerId.id,
		numcol: {
			color: numcol.color,
			number: numcol.number,
		},
	})),
})
