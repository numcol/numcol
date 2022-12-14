import { GameDto, GetGameUseCase } from "@numcol/app"
import { useEffect, useState } from "react"
import { StyleSheet } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { useLogger } from "../../hooks/useLogger"
import { useService } from "../../providers/DependencyInjectionProvider"
import { Routes, ScreenProps } from "../../routes"
import { GameBoard } from "./components/GameBoard"

export const GameScreen = ({ navigation, route }: ScreenProps<Routes.Game>) => {
	useLogger("Game screen")
	const [game, setGame] = useState<GameDto | undefined>()
	const getGameUseCase = useService(GetGameUseCase)

	useEffect(() => {
		void getGameUseCase.invoke({ gameId: route.params.gameId }).then((g) => {
			if (!g) {
				navigation.goBack()
				return
			}

			setGame(g)
		})
	}, [getGameUseCase, navigation, route.params.gameId])

	return (
		<SafeAreaView style={styles.container}>
			{game && <GameBoard game={game} />}
		</SafeAreaView>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		height: "100%",
		padding: 10,
	},
})
