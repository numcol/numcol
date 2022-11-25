import { Button, colors, fonts } from "@numcol/ds"
import { StyleSheet, Text, View } from "react-native"

export const HomeScreen = () => {
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
					Jugar
				</Button>
				<Button
					onPress={() => undefined}
					color={Button.Color.Green}
					fixedHeight
				>
					Modo infantil
				</Button>
				<Button onPress={() => undefined} color={Button.Color.Blue} fixedHeight>
					Puntuar app
				</Button>
				<Button
					onPress={() => undefined}
					color={Button.Color.Yellow}
					fixedHeight
				>
					Ajustes
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
