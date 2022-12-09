import { StyleSheet } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { Routes, ScreenProps } from "../../routes"
import { GameBoard } from "./components/GameBoard"

export const GameScreen = ({ navigation: _ }: ScreenProps<Routes.Game>) => {
	return (
		<SafeAreaView style={styles.container}>
			<GameBoard />
		</SafeAreaView>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		padding: 10,
	},
})
