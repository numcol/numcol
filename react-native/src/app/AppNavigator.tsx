import { createNativeStackNavigator } from "@react-navigation/native-stack"
import { useEffect } from "react"
import { useTranslation } from "../infrastructure/i18n"
import { useSettings } from "./providers/SettingsProvider"
import { RootStackParamList, Routes } from "./routes"
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
			}}
		>
			<Group>
				<Screen name={Routes.Home} component={HomeScreen} />
			</Group>
			<Group screenOptions={{ presentation: "modal" }}>
				<Screen name={Routes.Languages} component={LanguagesModal} />
			</Group>
		</Navigator>
	)
}
