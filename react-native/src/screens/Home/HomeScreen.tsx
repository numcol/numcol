import { Button, colors } from "@numcol/ds"
import { StyleSheet, Text, View } from "react-native"

export const HomeScreen = () => {
	return (
		<View style={styles.container}>
			<View style={styles.container2}>
				<Button onPress={() => undefined} color={Button.Color.Red}>
					Hola
				</Button>
				<Button onPress={() => undefined} color={Button.Color.Green}>
					Hola
				</Button>
				<Button onPress={() => undefined} color={Button.Color.Blue}>
					Hola
				</Button>
				<Button onPress={() => undefined} color={Button.Color.Yellow}>
					Hola
				</Button>
			</View>
			<View style={styles.container2}>
				<Text>Adios</Text>
			</View>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: colors.main.white,
		alignItems: "center",
		justifyContent: "center",
	},
	container2: {
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		height: 70,
		paddingLeft: 40,
		paddingRight: 40,
	},
	text: {
		fontFamily: "PoiretOne-Regular",
		fontSize: 40,
	},
})
