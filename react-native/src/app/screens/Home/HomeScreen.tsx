import { Button, colors, fonts } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { StyleSheet, Text, View } from "react-native"
import { Routes, ScreenProps } from "../../routes"

export const HomeScreen = ({ navigation }: ScreenProps<"Home">) => {
	const { t } = useTranslation()
	return (
		<View style={styles.container}>
			<View style={styles.titleContainer}>
				<Text style={styles.title}>NumCol</Text>
				<Text style={styles.subtitle}>
					The brain game about numbers & colors
				</Text>
			</View>
			<View style={styles.buttonsContainer}>
				<Button onPress={() => undefined} color={Button.Color.Red} fixedHeight>
					{t("play")}
				</Button>
				<Button
					onPress={() => undefined}
					color={Button.Color.Green}
					fixedHeight
				>
					{t("kids_level")}
				</Button>
				<Button onPress={() => undefined} color={Button.Color.Blue} fixedHeight>
					{t("rate")}
				</Button>
				<Button
					onPress={() => navigation.navigate(Routes.Settings)}
					color={Button.Color.Yellow}
					fixedHeight
				>
					{t("settings")}
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
