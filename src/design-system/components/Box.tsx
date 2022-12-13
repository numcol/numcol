import { ComponentType, memo, MemoExoticComponent } from "react"
import { StyleSheet, Text, View } from "react-native"
import { colors, fonts } from "../constants"

export enum BoxColor {
	Red = "Red",
	Blue = "Blue",
	Green = "Green",
	Yellow = "Yellow",
}

interface BoxProps {
	color: BoxColor
	title: string
	children: string
}

interface Box extends MemoExoticComponent<ComponentType<BoxProps>> {
	Color: typeof BoxColor
}

export const Box = memo(({ color, title, children }: BoxProps) => {
	const boxColor = boxColors[color]

	return (
		<View style={[styles.box]}>
			<View
				style={[
					styles.titleContainer,
					boxColor.backgroundColor,
					boxColor.borderColor,
				]}
			>
				<Text style={styles.title}>{title}</Text>
			</View>
			<View style={[styles.textContainer, boxColor.borderColor]}>
				<Text style={styles.text}>{children}</Text>
			</View>
		</View>
	)
}) as Box

Box.displayName = "Box"
Box.Color = BoxColor

const styles = StyleSheet.create({
	box: {
		width: "100%",
	},
	titleContainer: {
		width: "100%",
		padding: 5,
		borderLeftWidth: 2,
		borderRightWidth: 2,
		borderTopWidth: 2,
		borderTopLeftRadius: 15,
		borderTopRightRadius: 15,
	},
	title: {
		width: "100%",
		textAlign: "center",
		color: colors.main.white,
		fontFamily: fonts.fredoka,
	},
	textContainer: {
		width: "100%",
		padding: 5,
		borderColor: colors.main.lightGrey,
		borderLeftWidth: 2,
		borderRightWidth: 2,
		borderBottomWidth: 2,
		backgroundColor: colors.main.white,
		flexDirection: "row",
		borderBottomLeftRadius: 15,
		borderBottomRightRadius: 15,
		height: 40,
		justifyContent: "center",
		alignItems: "center",
		overflow: "hidden",
	},
	text: {
		width: "100%",
		textAlign: "center",
		color: colors.main.black,
		fontFamily: fonts.fredokaBold,
		fontSize: 18,
		textTransform: "uppercase",
		overflow: "hidden",
	},
	redBorderColor: {
		borderColor: colors.main.red,
	},
	greenBorderColor: {
		borderColor: colors.main.green,
	},
	blueBorderColor: {
		borderColor: colors.main.blue,
	},
	yellowBorderColor: {
		borderColor: colors.main.yellow,
	},
	redBackgroundColor: {
		backgroundColor: colors.main.red,
	},
	greenBackgroundColor: {
		backgroundColor: colors.main.green,
	},
	blueBackgroundColor: {
		backgroundColor: colors.main.blue,
	},
	yellowBackgroundColor: {
		backgroundColor: colors.main.yellow,
	},
})

const boxColors: Record<
	BoxColor,
	{
		borderColor: { borderColor: string }
		backgroundColor: { backgroundColor: string }
	}
> = {
	[BoxColor.Red]: {
		borderColor: styles.redBorderColor,
		backgroundColor: styles.redBackgroundColor,
	},
	[BoxColor.Green]: {
		borderColor: styles.greenBorderColor,
		backgroundColor: styles.greenBackgroundColor,
	},
	[BoxColor.Blue]: {
		borderColor: styles.blueBorderColor,
		backgroundColor: styles.blueBackgroundColor,
	},
	[BoxColor.Yellow]: {
		borderColor: styles.yellowBorderColor,
		backgroundColor: styles.yellowBackgroundColor,
	},
}
