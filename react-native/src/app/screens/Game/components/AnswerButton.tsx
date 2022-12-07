import { Button, ButtonColor } from "@numcol/ds"
import { Dimensions, StyleSheet, View } from "react-native"
import { Answer } from "../../../../domain/game/answer"
import { NumcolColor } from "../../../../domain/game/color"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface AnsweButtonProps {
	answer: Answer
	onPress: () => void
}

const colorMapping: Record<NumcolColor, ButtonColor> = {
	[NumcolColor.Blue]: Button.Color.Blue,
	[NumcolColor.Red]: Button.Color.Red,
	[NumcolColor.Green]: Button.Color.Green,
	[NumcolColor.Yellow]: Button.Color.Yellow,
}

export const AnswerButton = ({ answer, onPress }: AnsweButtonProps) => {
	return (
		<View style={styles.container}>
			<Button onPress={onPress} color={colorMapping[answer.numcol.color]}>
				{answer.number.toString()}
			</Button>
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
