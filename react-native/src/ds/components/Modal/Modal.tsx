import { FontAwesomeIcon } from "@fortawesome/react-native-fontawesome"
import { StyleSheet, TouchableOpacity, View } from "react-native"

import { faClose } from "@fortawesome/free-solid-svg-icons/faClose"
import { ReactNode } from "react"
import { colors } from "../../constants"

interface ModalProps {
	close: () => void
	closeText: string
	children: ReactNode
}

export const Modal = ({ close, closeText, children }: ModalProps) => {
	return (
		<View style={styles.modal}>
			<View style={styles.closeButton}>
				<TouchableOpacity
					accessible={true}
					accessibilityLabel={closeText}
					onPress={close}
				>
					<FontAwesomeIcon icon={faClose} color={colors.main.black} size={32} />
				</TouchableOpacity>
			</View>
			<View style={styles.container}>{children}</View>
		</View>
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
		padding: 10,
		width: "100%",
		flexDirection: "row",
		justifyContent: "flex-end",
	},
})
