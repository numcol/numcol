import { colors, fonts } from "@numcol/ds"
import { StackActions } from "@react-navigation/native"
import { useCallback, useEffect, useMemo, useRef, useState } from "react"
import { Animated, Dimensions, StyleSheet, Text } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"
import { useLogger } from "../../hooks/useLogger"
import { useSound } from "../../hooks/useSound"
import { Routes, ScreenProps } from "../../routes"

const duration = 500

const windowHeight = Dimensions.get("window").height

export const CountDownScreen = ({
	navigation,
}: ScreenProps<Routes.CountDown>) => {
	const isGoingOut = useRef(false)
	const starting3 = useRef(3)
	const starting2 = useRef(2)
	const [starting3Text, setStarting3Text] = useState(String(starting3.current))
	const [starting2Text, setStarting2Text] = useState(String(starting2.current))
	const fromUpToMiddleValue = useRef(new Animated.Value(0))
	const fromMiddleToDownValue = useRef(new Animated.Value(-windowHeight))
	const { countDown, start } = useSound()

	useLogger("Countdown screen")

	const fromUpToMiddle = useMemo(
		() =>
			Animated.timing(fromUpToMiddleValue.current, {
				toValue: windowHeight,
				duration,
				useNativeDriver: true,
			}),
		[],
	)

	const fromMiddleToDown = useMemo(
		() =>
			Animated.timing(fromMiddleToDownValue.current, {
				toValue: 0,
				duration,
				useNativeDriver: true,
			}),
		[],
	)

	const animate = useCallback(() => {
		if (!isGoingOut.current) {
			setStarting2Text(String(starting2.current))
		} else {
			setStarting3Text(String(starting3.current))
		}
		fromUpToMiddle.reset()
		fromMiddleToDown.reset()
		fromUpToMiddle.start()
		fromMiddleToDown.start(({ finished }) => {
			if (!finished) {
				return
			}
			if (isGoingOut.current) {
				starting2.current = starting2.current - 2
			} else {
				starting3.current = starting3.current - 2
			}
		})
	}, [fromMiddleToDown, fromUpToMiddle])

	useEffect(() => {
		let interval: NodeJS.Timer
		const timer = setTimeout(() => {
			void countDown.play()
			animate()

			interval = setInterval(() => {
				if (starting3.current <= 0) {
					void start.play()
					clearTimeout(timer)
					if (interval) {
						clearInterval(interval)
					}
					fromUpToMiddle.stop()
					fromMiddleToDown.stop()
					// navigation.navigate(Routes.Game)
					navigation.dispatch(StackActions.replace(Routes.Game))
					return
				}

				void countDown.play()
				isGoingOut.current = !isGoingOut.current
				animate()
			}, 1000)
		}, 1000)

		return () => {
			clearTimeout(timer)
			if (interval) {
				clearInterval(interval)
			}
			fromUpToMiddle.stop()
			fromMiddleToDown.stop()
		}
	}, [fromUpToMiddle, fromMiddleToDown, animate, navigation, countDown, start])

	return (
		<SafeAreaView style={styles.container}>
			<Animated.View
				style={[
					styles.container2,
					{
						transform: [
							{
								translateY: isGoingOut.current
									? fromMiddleToDownValue.current
									: fromUpToMiddleValue.current,
							},
						],
					},
				]}
			>
				<Text style={styles.countDown}>{starting3Text}</Text>
			</Animated.View>
			<Animated.View
				style={[
					styles.container2,
					{
						transform: [
							{
								translateY: !isGoingOut.current
									? fromMiddleToDownValue.current
									: fromUpToMiddleValue.current,
							},
						],
					},
				]}
			>
				<Text style={styles.countDown}>{starting2Text}</Text>
			</Animated.View>
		</SafeAreaView>
	)
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: colors.main.white,
		alignItems: "center",
		justifyContent: "center",
		padding: 40,
		width: "100%",
	},
	container2: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
		position: "absolute",
		width: "100%",
	},
	countDown: {
		fontFamily: fonts.fredokaBold,
		fontSize: 160,
	},
})
