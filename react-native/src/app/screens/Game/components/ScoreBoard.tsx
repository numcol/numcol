import { memo } from "react"
import { Dimensions, StyleSheet, Text, View } from "react-native"
import { useTranslation } from "../../../../infrastructure/i18n"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface ScoreBoardProps {
	score: number
}

export const ScoreBoard = memo(({ score }: ScoreBoardProps) => {
	const { t } = useTranslation()
	return (
		<View style={styles.container}>
			<Text>{t("score")}</Text>
			<Text>{score}</Text>
		</View>
	)
})

ScoreBoard.displayName = "ScoreBoard"

const styles = StyleSheet.create({
	container: {
		height: size,
		width: size,
		marginBottom: 5,
	},
})
