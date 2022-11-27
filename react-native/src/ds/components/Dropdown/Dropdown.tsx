import { useRef, useState } from "react"
import {
	FlatList,
	Modal,
	StyleSheet,
	Text,
	TouchableOpacity,
	View,
} from "react-native"
import { colors, fonts } from "../../constants"
import { Button } from "../Button/Button"

export interface DropdownItem {
	label: string
	value: string
}

interface DropdownProps {
	label: string
	data: Array<DropdownItem>
	onSelect: (item: DropdownItem) => void
}

export const Dropdown = ({ label, data, onSelect }: DropdownProps) => {
	const DropdownButton = useRef<TouchableOpacity>(null)
	const [visible, setVisible] = useState(false)
	const [selected, setSelected] = useState<
		{ label: string; value: string } | undefined
	>(undefined)
	const [dropdownTop, setDropdownTop] = useState(0)

	const toggleDropdown = (): void => {
		visible ? setVisible(false) : openDropdown()
	}

	const openDropdown = (): void => {
		DropdownButton.current?.measure(
			(
				_fx: number,
				_fy: number,
				_w: number,
				h: number,
				_px: number,
				py: number,
			) => {
				setDropdownTop(py + h)
			},
		)
		setVisible(true)
	}

	const onItemPress = (item: DropdownItem): void => {
		setSelected(item)
		onSelect(item)
		setVisible(false)
	}

	const renderItem = ({ item }: { item: DropdownItem }) => (
		<TouchableOpacity style={styles.item} onPress={() => onItemPress(item)}>
			<Text>{item.label}</Text>
		</TouchableOpacity>
	)

	const renderDropdown = () => {
		return (
			<Modal visible={visible} transparent animationType="none">
				<TouchableOpacity
					style={styles.overlay}
					onPress={() => setVisible(false)}
				>
					<View style={[styles.dropdown, { top: dropdownTop }]}>
						<FlatList
							data={data}
							renderItem={renderItem}
							keyExtractor={(_item, index) => index.toString()}
						/>
					</View>
				</TouchableOpacity>
			</Modal>
		)
	}

	return (
		<Button
			ref={DropdownButton}
			onPress={toggleDropdown}
			color={Button.Color.Green}
			fixedHeight
		>
			{renderDropdown()}
			{(!!selected && selected.label) || label}
		</Button>
	)
}

const styles = StyleSheet.create({
	button: {
		height: 70,
		width: "100%",
	},
	buttonContainer: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		backgroundColor: colors.main.lightGrey,
		borderRadius: 15,
		width: "100%",
	},
	buttonText: {
		textAlign: "center",
		color: colors.main.white,
		fontFamily: fonts.fredokaBold,
		fontSize: 32,
		textTransform: "uppercase" as const,
	},
	icon: {
		marginRight: 10,
	},
	dropdown: {
		position: "absolute",
		backgroundColor: "#fff",
		width: "100%",
		shadowColor: "#000000",
		shadowRadius: 4,
		shadowOffset: { height: 4, width: 0 },
		shadowOpacity: 0.5,
	},
	overlay: {
		width: "100%",
		height: "100%",
	},
	item: {
		paddingHorizontal: 10,
		paddingVertical: 10,
		borderBottomWidth: 1,
	},
})
