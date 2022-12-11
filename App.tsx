import { NumCol } from "@numcol/ui"
import { builder, detectLanguage, initI18n } from "@numcol/infra"
import { DefaultTheme, NavigationContainer } from "@react-navigation/native"
import { Asset } from "expo-asset"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"
import "intl-pluralrules"
import { useCallback, useEffect, useState } from "react"
import "react-native-gesture-handler"
import { SafeAreaProvider } from "react-native-safe-area-context"
import { useFetchAudios } from "./src/infrastructure/audio/useFetchAudios"

const navTheme = {
	...DefaultTheme,
	colors: {
		...DefaultTheme.colors,
		background: "transparent",
	},
}

void initI18n()
void SplashScreen.preventAutoHideAsync()

const images = {
	background: require("./assets/seamless-memphis-geometric-lines-pattern.png"),
}
const fonts = {
	"Fredoka-Regular": require("./assets/fonts/Fredoka-Regular.ttf"),
	"Fredoka-SemiBold": require("./assets/fonts/Fredoka-SemiBold.ttf"),
}

const preFetchImages = () =>
	Promise.all(Object.values(images).map((i) => Asset.loadAsync(i)))

const container = builder.build({ autowire: false })

const defaultSettings = {
	language: detectLanguage(),
	audio: true,
}

export default function App() {
	const [navigationContainerReady, setNavigationContainerReady] =
		useState(false)
	const [appReady, setAppReady] = useState(false)
	const [imagesLoaded, setImagesLoaded] = useState(false)
	const [fontsLoaded] = useFonts(fonts)
	const { audios, loaded: audiosLoaded } = useFetchAudios()

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
		if (
			fontsLoaded &&
			navigationContainerReady &&
			appReady &&
			imagesLoaded &&
			audiosLoaded
		) {
			void SplashScreen.hideAsync()
		}
	}, [
		fontsLoaded,
		navigationContainerReady,
		appReady,
		imagesLoaded,
		audiosLoaded,
	])

	if (!fontsLoaded) {
		return null
	}

	return (
		<SafeAreaProvider>
			<NavigationContainer
				theme={navTheme}
				onReady={onNavigationContainerReady}
			>
				<StatusBar style="dark" />
				<NumCol
					onReady={onAppReady}
					background={images.background}
					audios={audios}
					defaultSettings={defaultSettings}
					container={container}
				/>
			</NavigationContainer>
		</SafeAreaProvider>
	)
}
