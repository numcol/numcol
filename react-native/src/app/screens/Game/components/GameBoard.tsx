import { useCallback, useEffect, useState } from "react"
import { Answer } from "../../../../domain/game/answer"
import { Game } from "../../../../domain/game/game"
import { AnswerGrid } from "../components/AnswerGrid"
import { Question } from "../components/Question"
import { ScoreBoard } from "../components/ScoreBoard"

export const GameBoard = () => {
	const [game, setGame] = useState(Game.create())
	const [answer, setAnswer] = useState<Answer | undefined>()

	useEffect(() => {
		if (!answer) {
			return
		}

		setGame(game.reply(answer))
	}, [answer, game])

	const reply = useCallback((nanswer: Answer) => {
		setAnswer(nanswer)
	}, [])

	return (
		<>
			<ScoreBoard score={game.score} />
			<Question question={game.question} />
			<AnswerGrid answers={game.answers} reply={reply} />
		</>
	)
}
