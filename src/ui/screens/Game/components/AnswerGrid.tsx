import { AnswerDto } from "@numcol/app"
import { StyleSheet, View } from "react-native"
import { AnswerButton } from "./AnswerButton"

interface AnswerGridProps {
	answers: ReadonlyArray<AnswerDto>
	reply: (id: string) => void
}

export const AnswerGrid = ({ answers, reply }: AnswerGridProps) => {
	return (
		<View style={styles.container}>
			{answers.map((answer) => (
				<AnswerButton
					key={`answer${answer.id}`}
					answer={answer}
					reply={reply}
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
