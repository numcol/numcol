import { createNativeStackNavigator } from "@react-navigation/native-stack"
import { useEffect } from "react"
import { useTranslation } from "../infrastructure/i18n"
import { useSettings } from "./providers/SettingsProvider"
import { RootStackParamList, Routes } from "./routes"
import { HomeScreen } from "./screens/Home/HomeScreen"
import { SettingsScreen } from "./screens/Settings/SettingsScreen"

const { Navigator, Screen } = createNativeStackNavigator<RootStackParamList>()

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
			}}
		>
			<Screen name={Routes.Home} component={HomeScreen} />
			<Screen name={Routes.Settings} component={SettingsScreen} />
		</Navigator>
	)
}
