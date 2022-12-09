import { Background } from "../ds/components/Background/Background"
import { AppNavigator } from "./AppNavigator"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
}

export const NumCol = ({ onReady }: NumColProps) => {
	return (
		<SettingsProvider>
			<Background />
			<AppNavigator onReady={onReady} />
		</SettingsProvider>
	)
}
