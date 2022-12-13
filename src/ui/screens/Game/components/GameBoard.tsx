import { ReplyUseCase } from "@numcol/app"
import { Game } from "@numcol/domain"
import { ShakeView, ShakeViewRef } from "@numcol/ds"
import { useCallback, useEffect, useRef, useState } from "react"
import { StyleSheet, View } from "react-native"
import { useLogger } from "../../../hooks/useLogger"
import { useSound } from "../../../hooks/useSound"
import { useService } from "../../../providers/DependencyInjectionProvider"
import { AnswerGrid } from "./AnswerGrid"
import { Question } from "./Question"
import { ScoreBoard } from "./ScoreBoard"

interface GameBoardProps {
	game: Game
}

export const GameBoard = ({ game }: GameBoardProps) => {
	const replyUseCase = useService(ReplyUseCase)
	const [colorFirst, _setColorFirst] = useState(randomBoolean())
	const shakeView = useRef<ShakeViewRef>(null)
	const { info } = useLogger()
	const { gameBackground } = useSound()

	useEffect(() => {
		void gameBackground.play()

		return () => {
			void gameBackground.stop()
		}
	}, [gameBackground])

	useEffect(() => {
		info("Game start")
	}, [info])

	// useEffect(() => {
	// 	if (!answer) {
	// 		return
	// 	}

	// 	const isCorrect = answer.isCorrectFor(game.question)

	// 	if (isCorrect) {
	// 		void click.play()
	// 	} else {
	// 		void wrong.play()
	// 	}

	// 	const logInfo = JSON.stringify({
	// 		question: game.question.toString(),
	// 		answer: answer.numcol.toString(),
	// 	})

	// 	if (isCorrect) {
	// 		info(`Correct answer: ${logInfo}`)
	// 		setColorFirst(randomBoolean())
	// 	} else {
	// 		info(`Incorrect answer: ${logInfo}`)
	// 		shakeView.current?.shake()
	// 	}

	// 	setGame(game.reply(answer))
	// 	setAnswer(undefined)
	// }, [answer, game, info, click, wrong])

	const reply = useCallback(
		(answerId: string) => {
			void replyUseCase.invoke({ gameId: game.id.id, answerId })
		},
		[game.id.id, replyUseCase],
	)

	return (
		<View style={styles.container}>
			<ScoreBoard score={game.score} />
			<View style={styles.bottom}>
				<Question
					color={game.question.color}
					number={game.question.number}
					colorFirst={colorFirst}
				/>
				<ShakeView ref={shakeView}>
					<AnswerGrid answers={game.answers} reply={reply} />
				</ShakeView>
			</View>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "space-between",
		width: "100%",
		height: "100%",
	},
	bottom: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
	},
})

const randomBoolean = (): boolean => Math.random() > 0.5
