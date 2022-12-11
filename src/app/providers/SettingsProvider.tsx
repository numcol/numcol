import { Language, Settings } from "@numcol/domain"
import {
	createContext,
	ReactNode,
	useCallback,
	useContext,
	useEffect,
	useState,
} from "react"
import { Storage } from "../services"
import { useService } from "./DependencyInjectionProvider"

const settingsKey = "@numcol_settings"

interface SettingsContextProps {
	loaded: boolean
	language: Language
	audio: boolean
	setLanguage: (language: Language) => void
	toggleAudio: () => void
}

const SettingsContext = createContext<SettingsContextProps>({
	loaded: false,
	audio: true,
	language: Language.En,
	setLanguage: () => undefined,
	toggleAudio: () => undefined,
})

interface SettingsState {
	loaded: boolean
	settings: Settings
}

interface SettingsProviderProps {
	children: ReactNode
	defaultSettings: Settings
}

export const SettingsProvider = ({
	children,
	defaultSettings,
}: SettingsProviderProps) => {
	const storage = useService(Storage)
	const [state, setState] = useState<SettingsState>({
		loaded: false,
		settings: defaultSettings,
	})

	useEffect(() => {
		void storage.getItem(settingsKey).then((saved) => {
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
	}, [storage])

	const setLanguage = useCallback(
		(language: Language) => {
			setState((prev) => {
				const newSettings: Settings = { ...prev.settings, language }
				void storage.setItem(settingsKey, JSON.stringify(newSettings))
				return { settings: newSettings, loaded: prev.loaded }
			})
		},
		[storage],
	)

	const toggleAudio = useCallback(() => {
		setState((prev) => {
			const newSettings: Settings = {
				...prev.settings,
				audio: !prev.settings.audio,
			}
			void storage.setItem(settingsKey, JSON.stringify(newSettings))
			return { settings: newSettings, loaded: prev.loaded }
		})
	}, [storage])

	return (
		<SettingsContext.Provider
			value={{
				loaded: state.loaded,
				language: state.settings.language,
				audio: state.settings.audio,
				setLanguage,
				toggleAudio,
			}}
		>
			{children}
		</SettingsContext.Provider>
	)
}

export const useSettings = () => useContext(SettingsContext)
