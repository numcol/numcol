import i18n from "i18next"
import { initReactI18next } from "react-i18next"
import { NativeModules, Platform } from "react-native"
import { Languages } from "./languages"

import ca from "./translations/ca.json"
import en from "./translations/en.json"
import es from "./translations/es.json"
import eu from "./translations/eu.json"
import fr from "./translations/fr.json"
import gl from "./translations/gl.json"

const detectLanguage = (): Languages => {
	const deviceLanguage =
		Platform.OS === "ios"
			? NativeModules["SettingsManager"].settings.AppleLocale ||
			  NativeModules["SettingsManager"].settings.AppleLanguages[0] //iOS 13
			: NativeModules["I18nManager"].localeIdentifier

	if (typeof deviceLanguage !== "string") {
		return Languages.En
	}

	const sanitizedLanguage = deviceLanguage
		.trim()
		.substring(0, 2)
		.toLowerCase() as Languages
	if (Object.values(Languages).includes(sanitizedLanguage)) {
		return sanitizedLanguage
	}

	return Languages.En
}

export const initI18n = () =>
	i18n.use(initReactI18next).init({
		resources: {
			[Languages.Ca]: {
				translation: ca,
			},
			[Languages.En]: {
				translation: en,
			},
			[Languages.Es]: {
				translation: es,
			},
			[Languages.Eu]: {
				translation: eu,
			},
			[Languages.Fr]: {
				translation: fr,
			},
			[Languages.Gl]: {
				translation: gl,
			},
		},
		lng: detectLanguage(),
		fallbackLng: Languages.En,
		interpolation: {
			escapeValue: false,
		},
	})
