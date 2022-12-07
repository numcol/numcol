import { Dimensions, StyleSheet, Text, View } from "react-native"
import { Numcol } from "../../../../domain/game/numcol"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface QuestionProps {
	question: Numcol
}

export const Question = ({ question }: QuestionProps) => {
	return (
		<View style={styles.container}>
			<Text>
				{question.color}
				{question.number}
			</Text>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		height: size,
		width: size,
		marginBottom: 5,
	},
})
