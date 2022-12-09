import {
	forwardRef,
	ReactNode,
	useCallback,
	useImperativeHandle,
	useRef,
} from "react"
import { Animated } from "react-native"

interface ShakeViewProps {
	children: ReactNode
}

export interface ShakeViewRef {
	shake: () => void
}

export const ShakeView = forwardRef<ShakeViewRef, ShakeViewProps>(
	({ children }, ref) => {
		useImperativeHandle(ref, () => ({
			shake: () => {
				shake()
			},
		}))

		const shakeAnimationValue = useRef(new Animated.Value(0))

		const shake = useCallback(() => {
			Animated.sequence([
				Animated.timing(shakeAnimationValue.current, {
					toValue: 10,
					duration: 100,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: -10,
					duration: 100,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: 10,
					duration: 100,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: 0,
					duration: 100,
					useNativeDriver: true,
				}),
			]).start()
		}, [])

		return (
			<Animated.View
				style={{ transform: [{ translateX: shakeAnimationValue.current }] }}
			>
				{children}
			</Animated.View>
		)
	},
)

ShakeView.displayName = "ShakeView"
