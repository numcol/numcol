import { useEffect, useRef } from "react"
import {
	Animated,
	Dimensions,
	Easing,
	Image,
	StyleSheet,
	View,
} from "react-native"

// eslint-disable-next-line @typescript-eslint/no-var-requires
const image = require("../../../../assets/seamless-memphis-geometric-lines-pattern.png")

const screenHeight = Dimensions.get("window").height

const initialValue = 0
const initialToValue = 2
const snapshot = 100
const radius = screenHeight / 2

const interpolateCircularMotionOverX = () => {
	const inputRange = []
	const outputRange = []
	for (let i = 0; i <= snapshot * 2; ++i) {
		const value = i / snapshot
		const move = Math.sin(value * Math.PI * 2) * radius
		inputRange.push(value)
		outputRange.push(move)
	}
	return { inputRange, outputRange }
}

const interpolateCircularMotionOverY = () => {
	const inputRange = []
	const outputRange = []
	for (let i = 0; i <= snapshot * 2; ++i) {
		const value = i / snapshot
		const move = -Math.cos(value * Math.PI * 2) * radius
		inputRange.push(value)
		outputRange.push(move)
	}
	return { inputRange, outputRange }
}

export const Background = () => {
	const translateValue = useRef(new Animated.Value(initialValue)).current

	useEffect(() => {
		const translate = () => {
			translateValue.setValue(initialValue)
			Animated.timing(translateValue, {
				toValue: initialToValue,
				duration: 40000,
				easing: Easing.linear,
				useNativeDriver: true,
			}).start(() => {
				translate()
			})
		}

		translate()
	}, [translateValue])

	const translateAnimationX = translateValue.interpolate(
		interpolateCircularMotionOverX(),
	)

	const translateAnimationY = translateValue.interpolate(
		interpolateCircularMotionOverY(),
	)

	const AnimatedImage = Animated.createAnimatedComponent(Image)

	return (
		<View
			accessibilityIgnoresInvertColors={true}
			importantForAccessibility="no-hide-descendants"
			style={StyleSheet.absoluteFill}
		>
			<AnimatedImage
				resizeMode="repeat"
				source={image}
				style={[
					styles.background,
					[
						{
							transform: [
								{
									translateX: translateAnimationX,
								},
								{
									translateY: translateAnimationY,
								},
							],
						},
					],
				]}
			/>
		</View>
	)
}

const styles = StyleSheet.create({
	background: {
		opacity: 0.05,
		borderColor: "red",
		borderWidth: 5,
		position: "absolute",
		width: screenHeight * 3,
		height: screenHeight * 3,
		top: -screenHeight,
		left: -screenHeight,
		transform: [
			{
				translateX: 0,
			},
			{
				translateY: 0,
			},
		],
	},
})
