import { Button, colors, fonts } from "@numcol/ds"
import { useLogger, useTranslation } from "@numcol/infra"
import { Dimensions, StyleSheet, Text, View } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { useSettings } from "../../providers/SettingsProvider"
import { Routes, ScreenProps } from "../../routes"

// eslint-disable-next-line @typescript-eslint/no-var-requires

export const HomeScreen = ({ navigation }: ScreenProps<Routes.Home>) => {
	const { t } = useTranslation()
	const { language, audio, setAudio } = useSettings()
	useLogger("Home screen")

	return (
		<View style={styles.background}>
			<SafeAreaView style={styles.container}>
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
						icon="play"
						fixedHeight
					>
						{t("play")}
					</Button>
					<Button
						onPress={() => navigation.navigate(Routes.CountDown)}
						color={Button.Color.Green}
						fixedHeight
						icon="child"
					>
						{t("kids_level")}
					</Button>
					<Button
						onPress={() => setAudio(!audio)}
						color={Button.Color.Blue}
						fixedHeight
						icon={audio ? "volume-up" : "volume-mute"}
					>
						{t("sound")}
					</Button>
					<Button
						onPress={() => navigation.navigate(Routes.Languages)}
						color={Button.Color.Yellow}
						fixedHeight
						icon="language"
					>
						{t(`language_${language}`)}
					</Button>
				</View>
			</SafeAreaView>
		</View>
	)
}

const styles = StyleSheet.create({
	background: {
		flex: 1,
	},
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "space-between",
		padding: 40,
	},
	image: {
		flex: 1,
		justifyContent: "center",
		height: Dimensions.get("window").height,
		width: Dimensions.get("window").width,
		overflow: "hidden",
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
		fontFamily: fonts.fredokaBold,
		fontSize: 74,
		color: colors.main.black,
	},
	subtitle: {
		fontFamily: fonts.fredoka,
		fontSize: 14,
		color: colors.main.grey,
	},
})
