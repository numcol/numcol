import { CreateGameUseCase } from "@numcol/app"
import { Button, colors, fonts } from "@numcol/ds"
import { nanoid } from "nanoid"
import { useCallback, useEffect } from "react"
import { Dimensions, StyleSheet, Text, View } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { useLogger } from "../../hooks/useLogger"
import { useSound } from "../../hooks/useSound"
import { useTranslate } from "../../hooks/useTranslate"
import { useService } from "../../providers/DependencyInjectionProvider"
import { useSettings } from "../../providers/SettingsProvider"
import { Routes, ScreenProps } from "../../routes"
import { SoundButton } from "./components/SoundButton"

export const HomeScreen = ({ navigation }: ScreenProps<Routes.Home>) => {
	const { t } = useTranslate()
	const { language } = useSettings()
	const { homeBackground, click, countDown } = useSound()
	const createGameUseCase = useService(CreateGameUseCase)
	useLogger("Home screen")

	useEffect(() => {
		void homeBackground.play()

		return () => {
			void homeBackground.stop()
		}
	}, [homeBackground])

	useEffect(() => {
		const unsubscribe = navigation.addListener("focus", () => {
			void homeBackground.play()
		})

		return unsubscribe
	}, [navigation, homeBackground])

	const startGame = useCallback(() => {
		const gameId = nanoid()
		void createGameUseCase.invoke({ gameId })
		void homeBackground.stop()
		void countDown.play()
		navigation.navigate(Routes.CountDown, { gameId })
	}, [navigation, homeBackground, countDown, createGameUseCase])

	const changeLanguage = useCallback(() => {
		void click.play()
		navigation.navigate(Routes.Languages)
	}, [navigation, click])

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
						onPress={() => void click.play()}
						color={Button.Color.Red}
						icon="play"
						fixedHeight
					>
						{t("play")}
					</Button>
					<Button
						onPress={startGame}
						color={Button.Color.Green}
						fixedHeight
						icon="child"
					>
						{t("kids_level")}
					</Button>
					<SoundButton />
					<Button
						onPress={changeLanguage}
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