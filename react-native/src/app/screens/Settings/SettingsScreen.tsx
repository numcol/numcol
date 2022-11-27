import { Language } from "@numcol/domain"
import {
	Button,
	colors,
	Dropdown,
	DropdownItem,
	Label,
	PageTitle,
} from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { useState } from "react"
import { StyleSheet, View } from "react-native"
import { useSettings } from "../../providers/SettingsProvider"
import { Routes, ScreenProps } from "../../routes"

const availableLanguages: Record<Language, { label: string; value: Language }> =
	{
		[Language.En]: { label: "English", value: Language.En },
		[Language.Es]: { label: "Español", value: Language.Es },
		[Language.Fr]: { label: "Français", value: Language.Fr },
		[Language.Eu]: { label: "Euskara", value: Language.Eu },
		[Language.Gl]: { label: "Galego", value: Language.Gl },
		[Language.Ca]: { label: "Català", value: Language.Ca },
	}

const dropdownData = Object.values(availableLanguages)

export const SettingsScreen = ({ navigation }: ScreenProps<"Settings">) => {
	const { t } = useTranslation()
	const { language, setLanguage } = useSettings()
	const [selected, setSelected] = useState<DropdownItem>(
		availableLanguages[language],
	)

	const handleLanguageChange = (item: DropdownItem) => {
		setLanguage(item.value as Language)
		setSelected(item)
	}

	return (
		<View style={styles.container}>
			<View style={styles.titleContainer}>
				<PageTitle>{t("settings")}</PageTitle>
			</View>

			<View style={styles.buttonContainer}>
				<View style={styles.fieldContainer}>
					<Label>{t("sound")}</Label>
					<Dropdown
						label={selected.label}
						data={dropdownData}
						onSelect={handleLanguageChange}
					/>
				</View>
				<View style={styles.fieldContainer}>
					<Label>{t("language")}</Label>
					<Dropdown
						label={selected.label}
						data={dropdownData}
						onSelect={handleLanguageChange}
					/>
				</View>
				<View style={styles.backContainer}>
					<Button
						onPress={() => navigation.navigate(Routes.Home)}
						color={Button.Color.Yellow}
						fixedHeight
					>
						{t("back_to_menu")}
					</Button>
				</View>
			</View>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "space-between",
		width: "100%",
		padding: 40,
		backgroundColor: colors.main.white,
	},
	titleContainer: {
		flex: 1,
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
	},
	backContainer: {
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
		marginTop: 40,
	},
	fieldContainer: {
		width: "100%",
		alignItems: "center",
		justifyContent: "center",
		paddingBottom: 5,
	},
	buttonContainer: {
		height: 320,
		alignItems: "center",
		justifyContent: "flex-end",
		width: "100%",
		marginBottom: 40,
		padding: 0,
	},
})
