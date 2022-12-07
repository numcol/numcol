import { NumCol } from "@numcol/app"
import { initI18n } from "@numcol/infra"
import { NavigationContainer } from "@react-navigation/native"
import { Asset } from "expo-asset"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"
import "intl-pluralrules"
import { useCallback, useEffect, useState } from "react"
import { SafeAreaProvider } from "react-native-safe-area-context"

void initI18n()
void SplashScreen.preventAutoHideAsync()

const images = [
	require("./assets/seamless-memphis-geometric-lines-pattern.png"),
]
const fonts = {
	"Fredoka-Regular": require("./assets/fonts/Fredoka-Regular.ttf"),
	"Fredoka-SemiBold": require("./assets/fonts/Fredoka-SemiBold.ttf"),
}

const preFetchImages = () => Promise.all(images.map((i) => Asset.loadAsync(i)))

export default function App() {
	const [navigationContainerReady, setNavigationContainerReady] =
		useState(false)
	const [appReady, setAppReady] = useState(false)
	const [imagesLoaded, setImagesLoaded] = useState(false)
	const [fontsLoaded] = useFonts(fonts)

	useEffect(() => {
		void preFetchImages().finally(() => setImagesLoaded(true))
	}, [])

	const onNavigationContainerReady = useCallback(async () => {
		setNavigationContainerReady(true)
	}, [])

	const onAppReady = useCallback(async () => {
		setAppReady(true)
	}, [])

	useEffect(() => {
		if (fontsLoaded && navigationContainerReady && appReady && imagesLoaded) {
			void SplashScreen.hideAsync()
		}
	}, [fontsLoaded, navigationContainerReady, appReady, imagesLoaded])

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
