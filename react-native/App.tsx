import { initI18n } from "@numcol/i18n"
import {
	HomeScreen,
	RootStackParamList,
	Routes,
	SettingsScreen,
} from "@numcol/screens"
import { NavigationContainer } from "@react-navigation/native"
import { createNativeStackNavigator } from "@react-navigation/native-stack"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"
import { useCallback } from "react"

initI18n()

SplashScreen.preventAutoHideAsync()
const Stack = createNativeStackNavigator<RootStackParamList>()

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
		<NavigationContainer onReady={onLayoutRootView}>
			<StatusBar style="dark" />
			<Stack.Navigator
				initialRouteName={Routes.Home}
				screenOptions={{
					headerShown: false,
				}}
			>
				<Stack.Screen name={Routes.Home} component={HomeScreen} />
				<Stack.Screen name={Routes.Settings} component={SettingsScreen} />
			</Stack.Navigator>
		</NavigationContainer>
	)
}
