import { NumCol } from "@numcol/app"
import { initI18n } from "@numcol/infra"
import { NavigationContainer } from "@react-navigation/native"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"

import "intl-pluralrules"
import { useCallback, useEffect, useState } from "react"
import { SafeAreaProvider } from "react-native-safe-area-context"

void initI18n()
void SplashScreen.preventAutoHideAsync()

export default function App() {
	const [navigationContainerReady, setNavigationContainerReady] =
		useState(false)
	const [appReady, setAppReady] = useState(false)
	const [fontsLoaded] = useFonts({
		"PoiretOne-Regular": require("./assets/fonts/PoiretOne-Regular.ttf"),
		"Fredoka-Regular": require("./assets/fonts/Fredoka-Regular.ttf"),
		"Fredoka-SemiBold": require("./assets/fonts/Fredoka-SemiBold.ttf"),
	})

	const onNavigationContainerReady = useCallback(async () => {
		setNavigationContainerReady(true)
	}, [])

	const onAppReady = useCallback(async () => {
		setAppReady(true)
	}, [])

	useEffect(() => {
		if (fontsLoaded && navigationContainerReady && appReady) {
			void SplashScreen.hideAsync()
		}
	}, [fontsLoaded, navigationContainerReady, appReady])

	if (!fontsLoaded) {
		return null
	}

	return (
		<SafeAreaProvider>
			<NavigationContainer onReady={onNavigationContainerReady}>
				<StatusBar style="dark" />
				<NumCol onReady={onAppReady} />
			</NavigationContainer>
		</SafeAreaProvider>
	)
}
