import { faChildReaching } from "@fortawesome/free-solid-svg-icons/faChildReaching"
import { faLanguage } from "@fortawesome/free-solid-svg-icons/faLanguage"
import { faPlay } from "@fortawesome/free-solid-svg-icons/faPlay"
import { faVolumeMute } from "@fortawesome/free-solid-svg-icons/faVolumeMute"
import { Button, colors, fonts } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { StyleSheet, Text, View } from "react-native"
import { useSettings } from "../../providers/SettingsProvider"
import { Routes, ScreenProps } from "../../routes"

export const HomeScreen = ({ navigation }: ScreenProps<"Home">) => {
	const { t } = useTranslation()
	const { language } = useSettings()

	return (
		<View style={styles.container}>
			<View style={styles.titleContainer}>
				<Text style={styles.title}>NumCol</Text>
				<Text style={styles.subtitle}>
					The brain game about numbers & colors
				</Text>
			</View>
			<View style={styles.buttonsContainer}>
				<Button
					onPress={() => undefined}
					color={Button.Color.Red}
					icon={faPlay}
					fixedHeight
				>
					{t("play")}
				</Button>
				<Button
					onPress={() => undefined}
					color={Button.Color.Green}
					fixedHeight
					icon={faChildReaching}
				>
					{t("kids_level")}
				</Button>
				<Button
					onPress={() => undefined}
					color={Button.Color.Blue}
					fixedHeight
					icon={faVolumeMute}
				>
					{t("sound")}
				</Button>
				<Button
					onPress={() => navigation.navigate(Routes.Languages)}
					color={Button.Color.Yellow}
					fixedHeight
					icon={faLanguage}
				>
					{t(`language_${language}`)}
				</Button>
			</View>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: colors.main.white,
		alignItems: "center",
		justifyContent: "space-between",
		padding: 40,
	},
	titleContainer: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
	},
	buttonsContainer: {
		alignItems: "center",
		justifyContent: "space-between",
		width: "100%",
		height: 320,
		marginBottom: 40,
	},
	title: {
		fontFamily: fonts.poiretOne,
		fontSize: 74,
		color: colors.main.black,
	},
	subtitle: {
		fontFamily: fonts.fredoka,
		fontSize: 14,
		color: colors.main.grey,
	},
})
