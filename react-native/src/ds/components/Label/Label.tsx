import { ReactNode } from "react"
import { StyleSheet, Text, View } from "react-native"
import { colors, fonts } from "../../constants"

interface LabelProps {
	children?: ReactNode
}

export const Label = ({ children }: LabelProps) => {
	return (
		<View style={styles.container}>
			<Text style={styles.text}>{children}</Text>
		</View>
	)
}

const styles = StyleSheet.create({
	container: {
		width: "100%",
		paddingBottom: 5,
	},
	text: {
		fontFamily: fonts.fredoka,
		fontSize: 18,
		color: colors.main.grey,
	},
})
