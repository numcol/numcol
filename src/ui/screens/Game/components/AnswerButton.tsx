import { AnswerDto } from "@numcol/app"
import {
	GameCorrectlyAnswered,
	GameEventNames,
	NumcolColor,
	NumcolNumber,
} from "@numcol/domain"
import { Button, ButtonColor } from "@numcol/ds"
import { memo, useCallback, useState } from "react"
import { Dimensions, StyleSheet, View } from "react-native"
import { useSubscribeTo } from "../../../hooks/useSubscribeTo"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface AnsweButtonProps {
	answer: AnswerDto
	reply: (id: string) => void
}

export const AnswerButton = memo(({ answer, reply }: AnsweButtonProps) => {
	const [numcol, setNumcol] = useState(answer.numcol)
	const { on: onGameCorrectlyAnswered } = useSubscribeTo<GameCorrectlyAnswered>(
		GameEventNames.GameCorrectlyAnswered,
	)
	onGameCorrectlyAnswered((ev) => {
		if (ev.answerId !== answer.id) {
			return
		}
		setNumcol(ev.newAnswerValue)
	})

	const onPress = useCallback(() => {
		reply(answer.id)
	}, [answer.id, reply])

	return (
		<View style={styles.container}>
			<Button onPress={onPress} color={colorMapping[numcol.color]}>
				{numbers[numcol.number].toString()}
			</Button>
		</View>
	)
})

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