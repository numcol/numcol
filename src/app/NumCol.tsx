import { Identifier } from "diod"
import { ImageURISource } from "react-native"
import { AppNavigator } from "./AppNavigator"
import { Background } from "./Background"
import { AppAudios, AudioProvider } from "./providers/AudioProvider"
import { DependencyInjectionProvider } from "./providers/DependencyInjectionProvider"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
	background: ImageURISource
	audios: AppAudios
	container: {
		get<T>(identifier: Identifier<T>): T
	}
}

export const NumCol = ({
	onReady,
	background,
	audios,
	container,
}: NumColProps) => {
	return (
		<DependencyInjectionProvider container={container}>
			<SettingsProvider>
				<AudioProvider audios={audios}>
					<Background image={background} />
					<AppNavigator onReady={onReady} />
				</AudioProvider>
			</SettingsProvider>
		</DependencyInjectionProvider>
	)
}
