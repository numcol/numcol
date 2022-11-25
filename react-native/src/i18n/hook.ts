import { useCallback } from "react"
import { useTranslation as useTranslationI18n } from "react-i18next"
import { Languages } from "./languages"

export const useTranslation = (): {
	t: (key: string) => string
	changeLanguage: (language: Languages) => void
	currentLanguage: Languages
} => {
	const { t, i18n } = useTranslationI18n()
	const changeLanguage = useCallback(
		(language: Languages) => i18n.changeLanguage(language),
		[i18n],
	)
	return { t, changeLanguage, currentLanguage: i18n.language as Languages }
}
