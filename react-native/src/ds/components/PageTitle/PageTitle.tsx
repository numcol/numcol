import { ReactNode } from "react"
import { StyleSheet, Text } from "react-native"
import { colors, fonts } from "../../constants"

interface LabelProps {
	children?: ReactNode
}

export const PageTitle = ({ children }: LabelProps) => {
	return <Text style={styles.text}>{children}</Text>
}

const styles = StyleSheet.create({
	text: {
		fontFamily: fonts.poiretOne,
		fontSize: 36,
		color: colors.main.black,
		textTransform: "uppercase",
	},
})
