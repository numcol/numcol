import { Background } from "@numcol/ds"
import { useCallback, useState } from "react"
import { StyleSheet } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { Answer } from "../../../domain/game/answer"
import { Game } from "../../../domain/game/game"
import { Routes, ScreenProps } from "../../routes"
import { GameBoard } from "./components/GameBoard"
import { Question } from "./components/Question"
import { ScoreBoard } from "./components/ScoreBoard"

export const GameScreen = ({ navigation: _ }: ScreenProps<Routes.Game>) => {
	const [game, setGame] = useState(Game.create())

	const onReply = useCallback(
		(answer: Answer) => {
			setGame(game.reply(answer))
		},
		[game],
	)

	return (
		<SafeAreaView style={styles.container}>
			<Background />
			<ScoreBoard score={game.score} />
			<Question question={game.question} />
			<GameBoard game={game} onReply={onReply} />
		</SafeAreaView>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		padding: 10,
	},
})
