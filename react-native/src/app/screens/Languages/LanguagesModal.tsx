import { Language } from "@numcol/domain"
import { Button, Modal, PageTitle } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { StyleSheet, View } from "react-native"
import { useSettings } from "../../providers/SettingsProvider"
import { ScreenProps } from "../../routes"

const availableLanguages = [
	Language.En,
	Language.Es,
	Language.Fr,
	Language.Eu,
	Language.Ca,
	Language.Gl,
]

export const LanguagesModal = ({ navigation }: ScreenProps<"Languages">) => {
	const { t } = useTranslation()
	const { language, setLanguage } = useSettings()

	const selectLanguage = (lng: Language) => {
		setLanguage(lng)
		navigation.goBack()
	}

	return (
		<Modal close={() => navigation.goBack()} closeText={t("back_to_menu")}>
			<View style={styles.container}>
				<View style={styles.titleContainer}>
					<PageTitle>{t("language")}</PageTitle>
				</View>

				<View style={styles.buttonContainer}>
					{availableLanguages.map((lng) => (
						<View key={`lng_button_${lng}`} style={styles.fieldContainer}>
							<Button
								onPress={() => selectLanguage(lng)}
								color={Button.Color.Blue}
								fixedHeight
								icon={language === lng ? "check-circle" : "circle"}
							>
								{t(`language_${lng}`)}
							</Button>
						</View>
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
	fieldContainer: {
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
		paddingBottom: 5,
	},
	buttonContainer: {
		alignItems: "center",
		justifyContent: "flex-end",
		width: "100%",
		padding: 0,
	},
})
