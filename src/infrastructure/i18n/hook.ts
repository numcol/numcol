import { Language } from "@numcol/domain"
import { useCallback } from "react"
import { useTranslation as useTranslationI18n } from "react-i18next"

export const useTranslation = (): {
	t: (key: string) => string
	changeLanguage: (language: Language) => void
} => {
	const { t, i18n } = useTranslationI18n()
	const changeLanguage = useCallback(
		(language: Language) => i18n.changeLanguage(language),
		[i18n],
	)
	return { t, changeLanguage }
}
