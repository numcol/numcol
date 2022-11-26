import { Language, Settings } from "@numcol/domain"
import { detectLanguage, useStorage } from "@numcol/infra"
import {
	createContext,
	ReactNode,
	useCallback,
	useContext,
	useEffect,
	useState,
} from "react"

const settingsKey = "@numcol_settings"
const defaultSettings: Settings = {
	language: detectLanguage(),
}

const SettingsContext = createContext<{
	loaded: boolean
	language: Language
	setLanguage: (language: Language) => void
}>({
	loaded: false,
	language: detectLanguage(),
	setLanguage: () => undefined,
})

interface SettingsProviderProps {
	children: ReactNode
}

export const SettingsProvider = ({ children }: SettingsProviderProps) => {
	const { getItem, setItem } = useStorage()
	const [state, setState] = useState<{
		loaded: boolean
		settings: Settings
	}>({
		loaded: false,
		settings: defaultSettings,
	})

	useEffect(() => {
		void getItem(settingsKey).then((saved) => {
			try {
				if (!saved) {
					setState((prev) => ({ ...prev, loaded: true }))
					return
				}

				const savedSettings = JSON.parse(saved) as Partial<Settings>
				setState((prev) => ({
					settings: {
						language: savedSettings.language ?? prev.settings.language,
					},
					loaded: true,
				}))
			} catch {
				setState((prev) => ({ ...prev, loaded: true }))
			}
		})
	}, [getItem])

	const setLanguage = useCallback(
		(language: Language) => {
			setState((prev) => {
				const newSettings = { ...prev.settings, language }
				void setItem(settingsKey, JSON.stringify(newSettings))
				return { settings: newSettings, loaded: prev.loaded }
			})
		},
		[setItem],
	)

	return (
		<SettingsContext.Provider
			value={{
				loaded: state.loaded,
				language: state.settings.language,
				setLanguage,
			}}
		>
			{children}
		</SettingsContext.Provider>
	)
}

export const useSettings = (): {
	loaded: boolean
	language: Language
	setLanguage: (language: Language) => void
} => {
	return useContext(SettingsContext)
}
