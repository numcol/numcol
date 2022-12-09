import { useCallback, useEffect, useRef, useState } from "react"
import { Answer } from "../../../../domain/game/answer"
import { Game } from "../../../../domain/game/game"
import { AnswerGrid } from "../components/AnswerGrid"
import { Question } from "../components/Question"
import { ScoreBoard } from "../components/ScoreBoard"
import { ShakeView, ShakeViewRef } from "./ShakeView"

export const GameBoard = () => {
	const [game, setGame] = useState(Game.create())
	const [answer, setAnswer] = useState<Answer | undefined>()
	const shakeView = useRef<ShakeViewRef>(null)

	useEffect(() => {
		if (!answer) {
			return
		}

		if (!answer.isCorrectFor(game.question)) {
			shakeView.current?.shake()
		}

		setGame(game.reply(answer))
		setAnswer(undefined)
	}, [answer, game])

	const reply = useCallback((nanswer: Answer) => {
		setAnswer(nanswer)
	}, [])

	return (
		<>
			<ScoreBoard score={game.score} />
			<Question question={game.question} />
			<ShakeView ref={shakeView}>
				<AnswerGrid answers={game.answers} reply={reply} />
			</ShakeView>
		</>
	)
}
