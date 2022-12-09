import { Language } from "@numcol/domain"
import { Button } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { memo } from "react"
import { StyleSheet, View } from "react-native"
import { useSettings } from "../../../providers/SettingsProvider"

interface LanguageButtonProps {
	lng: Language
	selectLanguage: (lng: Language) => void
}

export const LanguageButton = memo(
	({ lng, selectLanguage }: LanguageButtonProps) => {
		const { t } = useTranslation()
		const { language } = useSettings()

		return (
			<View key={`lng_button_${lng}`} style={styles.container}>
				<Button
					onPress={() => selectLanguage(lng)}
					color={Button.Color.Blue}
					fixedHeight
					icon={language === lng ? "check-circle" : "circle"}
				>
					{t(`language_${lng}`)}
				</Button>
			</View>
		)
	},
)

LanguageButton.displayName = "LanguageButton"

const styles = StyleSheet.create({
	container: {
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
		paddingBottom: 5,
	},
})
