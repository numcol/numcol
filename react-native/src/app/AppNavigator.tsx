import { createNativeStackNavigator } from "@react-navigation/native-stack"
import { useEffect } from "react"
import { colors } from "../ds/constants"
import { useTranslation } from "../infrastructure/i18n"
import { useSettings } from "./providers/SettingsProvider"
import { RootStackParamList, Routes } from "./routes"
import { CountDownScreen } from "./screens/CountDown/CountDownScreen"
import { GameScreen } from "./screens/Game/GameScreen"
import { HomeScreen } from "./screens/Home/HomeScreen"
import { LanguagesModal } from "./screens/Languages/LanguagesModal"

const { Navigator, Screen, Group } =
	createNativeStackNavigator<RootStackParamList>()

interface AppNavigatorProps {
	onReady?: () => void
}

export const AppNavigator = ({ onReady }: AppNavigatorProps) => {
	const { loaded, language } = useSettings()
	const { changeLanguage } = useTranslation()

	useEffect(() => {
		changeLanguage(language)
	}, [language, changeLanguage])

	useEffect(() => {
		if (loaded) {
			onReady?.()
		}
	}, [loaded, onReady])

	return (
		<Navigator
			initialRouteName={Routes.Home}
			screenOptions={{
				headerShown: false,
				contentStyle: { backgroundColor: colors.main.white },
			}}
		>
			<Group>
				<Screen name={Routes.Home} component={HomeScreen} />
				<Screen name={Routes.CountDown} component={CountDownScreen} />
				<Screen name={Routes.Game} component={GameScreen} />
			</Group>
			<Group screenOptions={{ presentation: "modal" }}>
				<Screen name={Routes.Languages} component={LanguagesModal} />
			</Group>
		</Navigator>
	)
}
