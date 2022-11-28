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
	audio: true,
}

interface SettingsContextProps {
	loaded: boolean
	language: Language
	audio: boolean
	setLanguage: (language: Language) => void
	setAudio: (audio: boolean) => void
}

const SettingsContext = createContext<SettingsContextProps>({
	loaded: false,
	audio: true,
	language: detectLanguage(),
	setLanguage: () => undefined,
	setAudio: () => undefined,
})

interface SettingsState {
	loaded: boolean
	settings: Settings
}

interface SettingsProviderProps {
	children: ReactNode
}

export const SettingsProvider = ({ children }: SettingsProviderProps) => {
	const { getItem, setItem } = useStorage()
	const [state, setState] = useState<SettingsState>({
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
						audio: savedSettings.audio ?? prev.settings.audio,
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
				const newSettings: Settings = { ...prev.settings, language }
				void setItem(settingsKey, JSON.stringify(newSettings))
				return { settings: newSettings, loaded: prev.loaded }
			})
		},
		[setItem],
	)

	const setAudio = useCallback(
		(audio: boolean) => {
			setState((prev) => {
				const newSettings: Settings = { ...prev.settings, audio }
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
				audio: state.settings.audio,
				setLanguage,
				setAudio,
			}}
		>
			{children}
		</SettingsContext.Provider>
	)
}

export const useSettings = (): SettingsContextProps => {
	return useContext(SettingsContext)
}
