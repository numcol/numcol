import { Button, colors } from "@numcol/ds"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"
import { useCallback } from "react"
import { StyleSheet, Text, View } from "react-native"

SplashScreen.preventAutoHideAsync()

export default function App() {
	const [fontsLoaded] = useFonts({
		"PoiretOne-Regular": require("./assets/fonts/PoiretOne-Regular.ttf"),
		"Fredoka-Regular": require("./assets/fonts/Fredoka-Regular.ttf"),
		"Fredoka-SemiBold": require("./assets/fonts/Fredoka-SemiBold.ttf"),
	})

	const onLayoutRootView = useCallback(async () => {
		if (fontsLoaded) {
			await SplashScreen.hideAsync()
		}
	}, [fontsLoaded])

	if (!fontsLoaded) {
		return null
	}

	return (
		<View style={styles.container} onLayout={onLayoutRootView}>
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
			<StatusBar style="light" />
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
