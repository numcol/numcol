import { AppNavigator } from "./AppNavigator"
import { SettingsProvider } from "./providers/SettingsProvider"

interface NumColProps {
	onReady?: () => void
	jj: boolean
}

export const NumCol = ({ onReady }: NumColProps) => {
	return (
		<SettingsProvider>
			<AppNavigator onReady={onReady} />
		</SettingsProvider>
	)
}
