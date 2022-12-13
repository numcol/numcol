import { Answer } from "@numcol/domain"
import { StyleSheet, View } from "react-native"
import { AnswerButton } from "./AnswerButton"

interface AnswerGridProps {
	answers: Answer[]
	reply: (id: string) => void
}

export const AnswerGrid = ({ answers, reply }: AnswerGridProps) => {
	return (
		<View style={styles.container}>
			{answers.map((answer) => (
				<AnswerButton
					key={`answer${answer.id.id}`}
					id={answer.id.id}
					number={answer.numcol.number}
					color={answer.numcol.color}
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
