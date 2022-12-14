import { NumcolColor, NumcolNumber } from "@numcol/domain"
import { colors, FlipView, FlipViewRef, fonts } from "@numcol/ds"
import { memo, useEffect, useRef } from "react"
import { StyleSheet, Text, View } from "react-native"
import { useTranslate } from "../../../hooks/useTranslate"

interface QuestionProps {
	color: NumcolColor
	number: NumcolNumber
	colorFirst: boolean
}

export const Question = memo(({ color, number, colorFirst }: QuestionProps) => {
	const { t } = useTranslate()
	const flipView = useRef<FlipViewRef>(null)

	const questionTuple: [string, string] = colorFirst
		? [t(color), t(number)]
		: [t(number), t(color)]

	useEffect(() => {
		flipView.current?.flip()
	}, [color, number])

	return (
		<View style={styles.container}>
			<FlipView ref={flipView}>
				<View style={styles.box}>
					<Text style={[styles.text, styles.textGrow, styles.textRight]}>
						{questionTuple[0]}
					</Text>
					<Text style={[styles.text, styles.textCenter]}>·</Text>
					<Text style={[styles.text, styles.textGrow, styles.textLeft]}>
						{questionTuple[1]}
					</Text>
				</View>
			</FlipView>
		</View>
	)
})

Question.displayName = "Question"

const styles = StyleSheet.create({
	container: {
		width: "100%",
		marginVertical: 20,
	},
	box: {
		width: "100%",
		marginBottom: 5,
		padding: 20,
		borderRadius: 15,
		borderColor: colors.main.black,
		borderWidth: 2,
		backgroundColor: colors.main.white,
		flexDirection: "row",
		overflow: "hidden",
	},
	text: {
		color: colors.main.black,
		fontFamily: fonts.fredokaBold,
		fontSize: 24,
		textTransform: "uppercase",
	},
	textGrow: {
		flex: 1,
		letterSpacing: 1,
	},
	textCenter: {
		textAlign: "center",
		paddingHorizontal: 10,
	},
	textRight: {
		textAlign: "right",
	},
	textLeft: {
		textAlign: "left",
	},
})