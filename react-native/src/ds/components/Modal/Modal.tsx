import FontAwesome from "@expo/vector-icons/FontAwesome5"
import { ReactNode } from "react"
import { StyleSheet, TouchableOpacity, View } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { colors } from "../../constants"

interface ModalProps {
	close: () => void
	closeText: string
	children: ReactNode
}

export const Modal = ({ close, closeText, children }: ModalProps) => {
	return (
		<SafeAreaView style={styles.modal}>
			<View style={styles.closeButton}>
				<TouchableOpacity
					accessible={true}
					accessibilityLabel={closeText}
					onPress={close}
				>
					<FontAwesome name="times-circle" color={colors.main.grey} size={32} />
				</TouchableOpacity>
			</View>
			<View style={styles.container}>{children}</View>
		</SafeAreaView>
	)
}

const styles = StyleSheet.create({
	modal: {
		flex: 1,
		width: "100%",
		height: "100%",
		alignItems: "center",
		justifyContent: "flex-start",
		backgroundColor: colors.main.white,
	},
	container: {
		flex: 1,
		alignItems: "center",
		justifyContent: "flex-end",
		width: "100%",
		padding: 40,
	},
	closeButton: {
		padding: 20,
		width: "100%",
		flexDirection: "row",
		justifyContent: "flex-end",
	},
})
