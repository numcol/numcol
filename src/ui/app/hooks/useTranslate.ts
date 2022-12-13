import { Language } from "@numcol/domain"
import { useCallback } from "react"
import { useTranslation } from "react-i18next"

export const useTranslate = (): {
	t: (key: string) => string
	changeLanguage: (language: Language) => void
} => {
	const { t, i18n } = useTranslation()
	const changeLanguage = useCallback(
		(language: Language) => i18n.changeLanguage(language),
		[i18n],
	)
	return { t, changeLanguage }
}
