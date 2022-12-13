import { Box } from "@numcol/ds"
import { memo } from "react"
import { StyleSheet, View } from "react-native"
import { useTranslate } from "../../../hooks/useTranslate"

interface ScoreBoardProps {
	score: number
}

export const ScoreBoard = memo(({ score }: ScoreBoardProps) => {
	const { t } = useTranslate()
	return (
		<View style={styles.container}>
			<View style={styles.item}>
				<Box title={t("time")} color={Box.Color.Blue}>
					{`👶 ∞`}
				</Box>
			</View>
			<View style={styles.item}>
				<Box title={t("score")} color={Box.Color.Green}>
					{`⚡ ${score.toString()}`}
				</Box>
			</View>
		</View>
	)
})

ScoreBoard.displayName = "ScoreBoard"

const styles = StyleSheet.create({
	container: {
		width: "100%",
		justifyContent: "space-between",
		flexDirection: "row",
	},
	item: {
		flexDirection: "row",
		width: "40%",
	},
})
