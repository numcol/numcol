import { ImageURISource } from "react-native"
import { AppNavigator } from "./AppNavigator"
import { Background } from "./Background"
import { AudioObject, AudioProvider, Audios } from "./providers/AudioProvider"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
	background: ImageURISource
	audios: Record<Audios, AudioObject>
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
