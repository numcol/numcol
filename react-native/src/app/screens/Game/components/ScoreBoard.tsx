import { Dimensions, StyleSheet, Text, View } from "react-native"
import { useTranslation } from "../../../../infrastructure/i18n"

const size = (Dimensions.get("window").width - 20 - 25) / 6

interface ScoreBoardProps {
	score: number
}

export const ScoreBoard = ({ score }: ScoreBoardProps) => {
	const { t } = useTranslation()
	return (
		<View style={styles.container}>
			<Text>{t("score")}</Text>
			<Text>{score}</Text>
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
