import { NumCol } from "@numcol/app"
import { initI18n, useLogger } from "@numcol/infra"
import { DefaultTheme, NavigationContainer } from "@react-navigation/native"
import { Asset } from "expo-asset"
import { Audio } from "expo-av"
import { useFonts } from "expo-font"
import * as SplashScreen from "expo-splash-screen"
import { StatusBar } from "expo-status-bar"
import "intl-pluralrules"
import { useCallback, useEffect, useState } from "react"
import "react-native-gesture-handler"
import { SafeAreaProvider } from "react-native-safe-area-context"
import {
	AudioObject,
	Audios,
	fallbackAudioObject,
} from "./src/app/providers/AudioProvider"

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

const audios: Record<Audios, AudioObject> = {
	gameBackground: fallbackAudioObject,
}

export default function App() {
	const [navigationContainerReady, setNavigationContainerReady] =
		useState(false)
	const [appReady, setAppReady] = useState(false)
	const [imagesLoaded, setImagesLoaded] = useState(false)
	const [audiosLoaded, setAudiosLoaded] = useState(false)
	const [fontsLoaded] = useFonts(fonts)
	const { error, info } = useLogger()

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
		async function fetchAudios() {
			const audioObjects = await Promise.allSettled<
				Promise<[Audios, Audio.SoundObject]>[]
			>([
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("./assets/audio/POL-tower-climb-short.wav"),
					{
						isLooping: true,
					},
				).then((result) => [Audios.GameBackground, result]),
			])

			audioObjects.forEach((audio) => {
				if (audio.status === "rejected") {
					error(
						audio.reason instanceof Error
							? audio.reason
							: new Error(String(audio.reason)),
					)
					return
				}

				if (!audio.value[1].status.isLoaded) {
					error(
						new Error(
							`Error loading audio: ${
								audio.value[1].status.error ?? "unknown"
							}`,
						),
					)
					return
				}

				audios[audio.value[0]] = {
					play: () =>
						audio.value[1].sound
							.playAsync()
							.then(() => {
								info(`Audio played: ${audio.value[0]}`)
							})
							.catch(() => {
								info(`Audio can not be played: ${audio.value[0]}`)
							}),
				}
			})

			setAudiosLoaded(true)
		}

		void fetchAudios()
	}, [error])

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
				/>
			</NavigationContainer>
		</SafeAreaProvider>
	)
}
