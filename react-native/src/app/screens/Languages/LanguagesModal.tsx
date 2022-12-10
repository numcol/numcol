import { Language } from "@numcol/domain"
import { Modal, PageTitle } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { useCallback } from "react"
import { StyleSheet, View } from "react-native"
import { useSound } from "../../hooks/useSound"
import { useSettings } from "../../providers/SettingsProvider"
import { Routes, ScreenProps } from "../../routes"
import { LanguageButton } from "./components/LanguageButton"

const availableLanguages = [
	Language.En,
	Language.Es,
	Language.Fr,
	Language.Eu,
	Language.Ca,
	Language.Gl,
]

export const LanguagesModal = ({
	navigation,
}: ScreenProps<Routes.Languages>) => {
	const { t } = useTranslation()
	const { setLanguage } = useSettings()
	const { click } = useSound()

	const selectLanguage = useCallback(
		(lng: Language) => {
			void click.play()
			setLanguage(lng)
			navigation.goBack()
		},
		[navigation, setLanguage, click],
	)

	const close = useCallback(() => {
		void click.play()
		navigation.goBack()
	}, [navigation, click])

	return (
		<Modal close={close} closeText={t("back_to_menu")}>
			<View style={styles.container}>
				<View style={styles.titleContainer}>
					<PageTitle>{t("language")}</PageTitle>
				</View>

				<View style={styles.buttonContainer}>
					{availableLanguages.map((lng) => (
						<LanguageButton
							key={`lng_button_${lng}`}
							lng={lng}
							selectLanguage={selectLanguage}
						/>
					))}
				</View>
			</View>
		</Modal>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		width: "100%",
		alignItems: "center",
		justifyContent: "space-between",
	},
	titleContainer: {
		flex: 1,
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
	},
	buttonContainer: {
		alignItems: "center",
		justifyContent: "flex-end",
		width: "100%",
		padding: 0,
	},
})
