import { Button, ButtonColor } from "@numcol/ds"
import { memo, useCallback } from "react"
import { Dimensions, StyleSheet, View } from "react-native"
import { Answer } from "../../../../domain/game/answer"
import { NumcolColor } from "../../../../domain/game/color"
import { NumcolNumber } from "../../../../domain/game/number"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface AnsweButtonProps {
	color: NumcolColor
	number: NumcolNumber
	id: number
	reply: (answer: Answer) => void
}

export const AnswerButton = memo(
	({ id, color, number, reply }: AnsweButtonProps) => {
		const onPress = useCallback(() => {
			reply(Answer.fromValues(id, color, number))
		}, [color, id, number, reply])

		return (
			<View style={styles.container}>
				<Button onPress={onPress} color={colorMapping[color]}>
					{numbers[number].toString()}
				</Button>
			</View>
		)
	},
)

AnswerButton.displayName = "AnswerButton"

const styles = StyleSheet.create({
	container: {
		height: size,
		width: size,
		marginBottom: 5,
	},
})

const colorMapping: Record<NumcolColor, ButtonColor> = {
	[NumcolColor.Blue]: Button.Color.Blue,
	[NumcolColor.Red]: Button.Color.Red,
	[NumcolColor.Green]: Button.Color.Green,
	[NumcolColor.Yellow]: Button.Color.Yellow,
}

const numbers: Record<NumcolNumber, number> = {
	[NumcolNumber.One]: 1,
	[NumcolNumber.Two]: 2,
	[NumcolNumber.Three]: 3,
	[NumcolNumber.Four]: 4,
	[NumcolNumber.Five]: 5,
	[NumcolNumber.Six]: 6,
	[NumcolNumber.Seven]: 7,
	[NumcolNumber.Eight]: 8,
	[NumcolNumber.Nine]: 9,
}
