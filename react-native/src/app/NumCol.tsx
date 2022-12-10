import { ImageURISource } from "react-native"
import { AppNavigator } from "./AppNavigator"
import { Background } from "./Background"
import { AppAudios, AudioProvider } from "./providers/AudioProvider"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
	background: ImageURISource
	audios: AppAudios
}

export const NumCol = ({ onReady, background, audios }: NumColProps) => {
	return (
		<SettingsProvider>
			<AudioProvider audios={audios}>
				<Background image={background} />
				<AppNavigator onReady={onReady} />
			</AudioProvider>
		</SettingsProvider>
	)
}
