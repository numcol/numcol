import { StyleSheet, View } from "react-native"
import { Answer } from "../../../../domain/game/answer"
import { Game } from "../../../../domain/game/game"
import { AnswerButton } from "./AnswerButton"

interface GameBoardProps {
	game: Game
	onReply: (answer: Answer) => void
}

export const GameBoard = ({ game, onReply }: GameBoardProps) => {
	return (
		<View style={styles.container}>
			{game.answers.map((answer) => (
				<AnswerButton
					key={`answer${answer.id}`}
					answer={answer}
					onPress={() => onReply(answer)}
				/>
			))}
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		overflow: "hidden",
		width: "100%",
		flexDirection: "row",
		flexWrap: "wrap",
		justifyContent: "space-between",
	},
})
