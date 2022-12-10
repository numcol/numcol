import { useTranslation } from "@numcol/infra"
import {
	CardStyleInterpolators,
	createStackNavigator,
	TransitionPresets,
} from "@react-navigation/stack"
import { useEffect } from "react"
import { useSettings } from "./providers/SettingsProvider"
import { RootStackParamList, Routes } from "./routes"
import { CountDownScreen } from "./screens/CountDown/CountDownScreen"
import { GameScreen } from "./screens/Game/GameScreen"
import { HomeScreen } from "./screens/Home/HomeScreen"
import { LanguagesModal } from "./screens/Languages/LanguagesModal"

const { Navigator, Screen, Group } = createStackNavigator<RootStackParamList>()

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
				//cardOverlayEnabled: false,
				// cardShadowEnabled: false,
				//contentStyle: { backgroundColor: "transparent" },
			}}
		>
			<Group
				screenOptions={{
					headerShown: false,
					cardOverlayEnabled: false,
					cardShadowEnabled: false,
					cardStyle: { backgroundColor: "transparent" },
					...TransitionPresets.ScaleFromCenterAndroid,
				}}
			>
				<Screen name={Routes.Home} component={HomeScreen} />
				<Screen name={Routes.CountDown} component={CountDownScreen} />
				<Screen name={Routes.Game} component={GameScreen} />
			</Group>
			<Group
				screenOptions={{
					presentation: "modal",
					cardStyleInterpolator: CardStyleInterpolators.forVerticalIOS,
				}}
			>
				<Screen name={Routes.Languages} component={LanguagesModal} />
			</Group>
		</Navigator>
	)
}
