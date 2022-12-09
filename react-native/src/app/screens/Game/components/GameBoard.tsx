import { useCallback, useEffect, useRef, useState } from "react"
import { Answer } from "../../../../domain/game/answer"
import { Game } from "../../../../domain/game/game"
import { randomBoolean } from "../../../../domain/game/randomGenerator"
import { useLogger } from "../../../../infrastructure/logger"
import { AnswerGrid } from "../components/AnswerGrid"
import { Question } from "../components/Question"
import { ScoreBoard } from "../components/ScoreBoard"
import { ShakeView, ShakeViewRef } from "./ShakeView"

export const GameBoard = () => {
	const [game, setGame] = useState(Game.create())
	const [answer, setAnswer] = useState<Answer | undefined>()
	const [colorFirst, setColorFirst] = useState(randomBoolean())
	const shakeView = useRef<ShakeViewRef>(null)
	const { info } = useLogger()

	useEffect(() => {
		info("Game start")
	}, [info])

	useEffect(() => {
		if (!answer) {
			return
		}

		const logInfo = JSON.stringify({
			question: game.question.toString(),
			answer: answer.numcol.toString(),
		})

		if (answer.isCorrectFor(game.question)) {
			info(`Correct answer: ${logInfo}`)
			setColorFirst(randomBoolean())
		} else {
			info(`Incorrect answer: ${logInfo}`)
			shakeView.current?.shake()
		}

		setGame(game.reply(answer))
		setAnswer(undefined)
	}, [answer, game, info])

	const reply = useCallback((nanswer: Answer) => {
		setAnswer(nanswer)
	}, [])

	return (
		<>
			<ScoreBoard score={game.score} />
			<Question
				color={game.question.color}
				number={game.question.number}
				colorFirst={colorFirst}
			/>
			<ShakeView ref={shakeView}>
				<AnswerGrid answers={game.answers} reply={reply} />
			</ShakeView>
		</>
	)
}
