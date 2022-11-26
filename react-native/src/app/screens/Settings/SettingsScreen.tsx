import { Language } from "@numcol/domain"
import { Button, Dropdown, DropdownItem } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { useState } from "react"
import { StyleSheet, Text, View } from "react-native"
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
				<Text>NumCol</Text>
				<Text>The brain game about numbers & colors</Text>
				<Dropdown
					label={selected.label}
					data={dropdownData}
					onSelect={handleLanguageChange}
				/>
				<Button
					onPress={() => navigation.navigate(Routes.Home)}
					color={Button.Color.Blue}
					fixedHeight
				>
					{t("back_to_menu")}
				</Button>
			</View>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		padding: 40,
	},
	titleContainer: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
	},
})
