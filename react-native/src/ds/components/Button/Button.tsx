import { forwardRef, ForwardRefExoticComponent, RefAttributes } from "react"
import { Pressable, StyleSheet, Text, View } from "react-native"
import { colors, fonts } from "../../constants"

enum ButtonColor {
	Red = "Red",
	Blue = "Blue",
	Green = "Green",
	Yellow = "Yellow",
}

interface ButtonProps {
	onPress: () => void
	children?: React.ReactNode
	color: ButtonColor
	fixedHeight?: boolean
}

interface Button
	extends ForwardRefExoticComponent<ButtonProps & RefAttributes<View>> {
	Color: typeof ButtonColor
}

export const Button = forwardRef<View, ButtonProps>(
	({ onPress, children, color, fixedHeight }, ref) => {
		const buttonColor = buttonColors[color]

		return (
			<Pressable
				ref={ref}
				onPress={onPress}
				style={[styles.container, fixedHeight && styles.fixedHeight]}
			>
				{({ pressed }) => (
					<>
						<View
							style={[
								styles.buttonShadow,
								buttonColor.buttonShadowBackgroundColor,
							]}
							accessibilityElementsHidden
							importantForAccessibility="no-hide-descendants"
						></View>
						<View
							style={[
								styles.button,
								buttonColor.buttonBackgroundColor,
								pressed && styles.pressed,
							]}
						>
							<View
								style={styles.titleShadowContainer}
								accessibilityElementsHidden
								importantForAccessibility="no-hide-descendants"
							>
								<Text
									style={[
										styles.titleShadow,
										buttonColor.textShadowBackgroundColor,
									]}
								>
									{children}
								</Text>
							</View>
							<Text style={styles.title}>{children}</Text>
						</View>
					</>
				)}
			</Pressable>
		)
	},
) as Button

Button.displayName = "Button"

Button.Color = ButtonColor

const titleStyles = {
	textAlign: "center" as const,
	color: colors.main.white,
	fontFamily: fonts.fredokaBold,
	fontSize: 32,
	width: "100%",
	textTransform: "uppercase" as const,
}

const buttonStyles = {
	width: "100%",
	height: "83%",
	justifyContent: "center" as const,
	borderRadius: 15,
	backgroundColor: colors.main.red,
}

const styles = StyleSheet.create({
	container: {
		marginHorizontal: 16,
		width: "100%",
		height: "100%",
		borderRadius: 15,
		alignItems: "center",
	},
	button: buttonStyles,
	buttonShadow: {
		...buttonStyles,
		top: "17%",
		left: 0,
		position: "absolute",
		backgroundColor: colors.shadow.red,
	},
	title: titleStyles,
	titleShadowContainer: {
		position: "absolute",
		top: 4,
		left: 0,
		justifyContent: "center",
		width: "100%",
		height: "100%",
	},
	titleShadow: {
		...titleStyles,
		color: colors.shadow.red,
	},
	fixedHeight: {
		height: 70,
	},
	pressed: { top: "6%" },
	redButtonBackground: { backgroundColor: colors.main.red },
	redButtonShadowBackground: { backgroundColor: colors.shadow.red },
	redButtonTextShadowBackground: { color: colors.shadow.red },
	greenButtonBackground: { backgroundColor: colors.main.green },
	greenButtonShadowBackground: { backgroundColor: colors.shadow.green },
	greenButtonTextShadowBackground: { color: colors.shadow.green },
	blueButtonBackground: { backgroundColor: colors.main.blue },
	blueButtonShadowBackground: { backgroundColor: colors.shadow.blue },
	blueButtonTextShadowBackground: { color: colors.shadow.blue },
	yellowButtonBackground: { backgroundColor: colors.main.yellow },
	yellowButtonShadowBackground: { backgroundColor: colors.shadow.yellow },
	yellowButtonTextShadowBackground: { color: colors.shadow.yellow },
})

const buttonColors: Record<
	ButtonColor,
	{
		buttonBackgroundColor: { backgroundColor: string }
		buttonShadowBackgroundColor: { backgroundColor: string }
		textShadowBackgroundColor: { color: string }
	}
> = {
	[ButtonColor.Red]: {
		buttonBackgroundColor: styles.redButtonBackground,
		buttonShadowBackgroundColor: styles.redButtonShadowBackground,
		textShadowBackgroundColor: styles.redButtonTextShadowBackground,
	},
	[ButtonColor.Green]: {
		buttonBackgroundColor: styles.greenButtonBackground,
		buttonShadowBackgroundColor: styles.greenButtonShadowBackground,
		textShadowBackgroundColor: styles.greenButtonTextShadowBackground,
	},
	[ButtonColor.Blue]: {
		buttonBackgroundColor: styles.blueButtonBackground,
		buttonShadowBackgroundColor: styles.blueButtonShadowBackground,
		textShadowBackgroundColor: styles.blueButtonTextShadowBackground,
	},
	[ButtonColor.Yellow]: {
		buttonBackgroundColor: styles.yellowButtonBackground,
		buttonShadowBackgroundColor: styles.yellowButtonShadowBackground,
		textShadowBackgroundColor: styles.yellowButtonTextShadowBackground,
	},
}
