import FontAwesome from "@expo/vector-icons/FontAwesome5"
import { forwardRef, ForwardRefExoticComponent, RefAttributes } from "react"
import { Pressable, StyleSheet, Text, View } from "react-native"
import { colors, fonts } from "../../constants"

export enum ButtonColor {
	Red = "Red",
	Blue = "Blue",
	Green = "Green",
	Yellow = "Yellow",
}

interface ButtonProps {
	onPress: () => void
	children: string
	color: ButtonColor
	fixedHeight?: boolean
	icon?: string
}

interface Button
	extends ForwardRefExoticComponent<ButtonProps & RefAttributes<View>> {
	Color: typeof ButtonColor
}

export const Button = forwardRef<View, ButtonProps>(
	({ onPress, children, color, fixedHeight, icon }, ref) => {
		const buttonColor = buttonColors[color]

		return (
			<Pressable
				ref={ref}
				onPress={onPress}
				unstable_pressDelay={0}
				style={[styles.container, fixedHeight && styles.fixedHeight]}
				android_disableSound={true}
			>
				{({ pressed }) => (
					<>
						<View
							style={[
								styles.button,
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
								!!icon && styles.buttonWithIcon,
							]}
						>
							<View
								style={[
									styles.titleShadowContainer,
									!!icon && styles.buttonWithIcon,
								]}
								accessibilityElementsHidden
								importantForAccessibility="no-hide-descendants"
							>
								<Text
									style={[
										styles.title,
										styles.titleShadow,
										buttonColor.textShadowBackgroundColor,
									]}
								>
									{children}
								</Text>
								{icon && (
									<View style={styles.icon}>
										<FontAwesome
											name={icon}
											color={buttonColor.textShadowBackgroundColor.color}
											size={24}
										/>
									</View>
								)}
							</View>
							<Text style={styles.title}>{children}</Text>
							{icon && (
								<View style={styles.icon}>
									<FontAwesome
										name={icon}
										color={colors.main.white}
										size={24}
									/>
								</View>
							)}
						</View>
					</>
				)}
			</Pressable>
		)
	},
) as Button

Button.displayName = "Button"

Button.Color = ButtonColor

const styles = StyleSheet.create({
	container: {
		width: "100%",
		height: "100%",
		borderRadius: 15,
		alignItems: "center",
	},
	button: {
		width: "100%",
		height: "83%",
		justifyContent: "center",
		alignItems: "center",
		borderRadius: 15,
		backgroundColor: colors.main.red,
		flexDirection: "row",
		paddingLeft: 20,
		paddingRight: 20,
	},
	buttonShadow: {
		top: "17%",
		left: 0,
		position: "absolute",
		backgroundColor: colors.shadow.red,
	},
	title: {
		textAlign: "center" as const,
		color: colors.main.white,
		fontFamily: fonts.fredokaBold,
		fontSize: 28,
		textTransform: "uppercase",
	},
	titleShadowContainer: {
		position: "absolute",
		top: 4,
		left: 20,
		justifyContent: "center",
		alignItems: "center",
		width: "100%",
		height: "100%",
		flexDirection: "row",
	},
	titleShadow: {
		color: colors.shadow.red,
	},
	fixedHeight: {
		height: 70,
	},
	pressed: { top: 4 },
	icon: {
		justifyContent: "center",
		alignItems: "center",
		height: "100%",
		width: 32,
	},
	buttonWithIcon: {
		justifyContent: "space-between",
	},
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
