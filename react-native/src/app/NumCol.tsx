import { ImageURISource } from "react-native"
import { AppNavigator } from "./AppNavigator"
import { Background } from "./Background"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
	background: ImageURISource
}

export const NumCol = ({ onReady, background }: NumColProps) => {
	return (
		<SettingsProvider>
			<Background image={background} />
			<AppNavigator onReady={onReady} />
		</SettingsProvider>
	)
}
