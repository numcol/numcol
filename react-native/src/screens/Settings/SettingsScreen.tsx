import { Button, Dropdown, DropdownItem } from "@numcol/ds"
import { useTranslation } from "@numcol/i18n"
import { useState } from "react"
import { StyleSheet, Text, View } from "react-native"
import { Languages } from "../../i18n/languages"
import { Routes, ScreenProps } from "../routes"

const availableLanguages: Record<
	Languages,
	{ label: string; value: Languages }
> = {
	[Languages.En]: { label: "English", value: Languages.En },
	[Languages.Es]: { label: "Español", value: Languages.Es },
	[Languages.Fr]: { label: "Français", value: Languages.Fr },
	[Languages.Eu]: { label: "Euskara", value: Languages.Eu },
	[Languages.Gl]: { label: "Galego", value: Languages.Gl },
	[Languages.Ca]: { label: "Català", value: Languages.Ca },
}

const dropdownData = Object.values(availableLanguages)

export const SettingsScreen = ({ navigation }: ScreenProps<"Settings">) => {
	const { t, currentLanguage, changeLanguage } = useTranslation()
	const [selected, setSelected] = useState<DropdownItem>(
		availableLanguages[currentLanguage],
	)

	const handleLanguageChange = (item: DropdownItem) => {
		changeLanguage(item.value as Languages)
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
