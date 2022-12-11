import { Settings } from "@numcol/domain"
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
	defaultSettings: Settings
	container: {
		get<T>(identifier: Identifier<T>): T
	}
}

export const NumCol = ({
	onReady,
	background,
	audios,
	defaultSettings,
	container,
}: NumColProps) => {
	return (
		<DependencyInjectionProvider container={container}>
			<SettingsProvider defaultSettings={defaultSettings}>
				<AudioProvider audios={audios}>
					<Background image={background} />
					<AppNavigator onReady={onReady} />
				</AudioProvider>
			</SettingsProvider>
		</DependencyInjectionProvider>
	)
}
