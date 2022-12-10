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
	vertical?: boolean
}

export interface ShakeViewRef {
	shake: () => void
}

export const ShakeView = forwardRef<ShakeViewRef, ShakeViewProps>(
	({ children, vertical }, ref) => {
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
					duration: 50,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: -10,
					duration: 50,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: 10,
					duration: 50,
					useNativeDriver: true,
				}),
				Animated.timing(shakeAnimationValue.current, {
					toValue: 0,
					duration: 50,
					useNativeDriver: true,
				}),
			]).start()
		}, [])

		const transform = vertical
			? [{ translateY: shakeAnimationValue.current }]
			: [{ translateX: shakeAnimationValue.current }]

		return <Animated.View style={{ transform }}>{children}</Animated.View>
	},
)

ShakeView.displayName = "ShakeView"
