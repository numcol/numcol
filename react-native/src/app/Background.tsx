import { useEffect, useRef } from "react"
import {
	Animated,
	Dimensions,
	Easing,
	Image,
	ImageURISource,
	StyleSheet,
	View,
} from "react-native"

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

interface BackgroundProps {
	image: ImageURISource
}

export const Background = ({ image }: BackgroundProps) => {
	const translateValue = useRef(new Animated.Value(initialValue))

	useEffect(() => {
		const translate = () => {
			translateValue.current.setValue(initialValue)
			Animated.timing(translateValue.current, {
				toValue: initialToValue,
				duration: 60000,
				easing: Easing.linear,
				useNativeDriver: true,
			}).start(() => {
				translate()
			})
		}

		translate()
	}, [])

	const translateAnimationX = translateValue.current.interpolate(
		interpolateCircularMotionOverX(),
	)

	const translateAnimationY = translateValue.current.interpolate(
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
