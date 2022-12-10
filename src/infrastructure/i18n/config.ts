import { Language } from "@numcol/domain"
import i18n from "i18next"
import { initReactI18next } from "react-i18next"
import { NativeModules, Platform } from "react-native"

import ca from "./translations/ca.json"
import en from "./translations/en.json"
import es from "./translations/es.json"
import eu from "./translations/eu.json"
import fr from "./translations/fr.json"
import gl from "./translations/gl.json"

export const detectLanguage = (): Language => {
	const deviceLanguage =
		Platform.OS === "ios"
			? NativeModules["SettingsManager"].settings.AppleLocale ||
			  NativeModules["SettingsManager"].settings.AppleLanguages[0] //iOS 13
			: NativeModules["I18nManager"].localeIdentifier

	if (typeof deviceLanguage !== "string") {
		return Language.En
	}

	const sanitizedLanguage = deviceLanguage
		.trim()
		.substring(0, 2)
		.toLowerCase() as Language
	if (Object.values(Language).includes(sanitizedLanguage)) {
		return sanitizedLanguage
	}

	return Language.En
}

export const initI18n = () =>
	i18n.use(initReactI18next).init({
		resources: {
			[Language.Ca]: {
				translation: ca,
			},
			[Language.En]: {
				translation: en,
			},
			[Language.Es]: {
				translation: es,
			},
			[Language.Eu]: {
				translation: eu,
			},
			[Language.Fr]: {
				translation: fr,
			},
			[Language.Gl]: {
				translation: gl,
			},
		},
		lng: detectLanguage(),
		fallbackLng: Language.En,
		interpolation: {
			escapeValue: false,
		},
	})
