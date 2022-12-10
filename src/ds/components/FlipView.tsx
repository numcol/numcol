import {
	forwardRef,
	ReactNode,
	useCallback,
	useImperativeHandle,
	useRef,
} from "react"
import { Animated } from "react-native"

interface FlipViewProps {
	children: ReactNode
}

export interface FlipViewRef {
	flip: () => void
}

export const FlipView = forwardRef<FlipViewRef, FlipViewProps>(
	({ children }, ref) => {
		useImperativeHandle(ref, () => ({
			flip: () => {
				flip()
			},
		}))

		const flipAnimationValue = useRef(new Animated.Value(0))

		const flip = useCallback(() => {
			Animated.timing(flipAnimationValue.current, {
				toValue: 1,
				duration: 200,
				useNativeDriver: true,
			}).start(() => flipAnimationValue.current.setValue(0))
		}, [])

		const rotateY = flipAnimationValue.current.interpolate({
			inputRange: [0, 1],
			outputRange: ["0deg", "360deg"],
		})

		return (
			<Animated.View style={{ transform: [{ rotateY }] }}>
				{children}
			</Animated.View>
		)
	},
)

FlipView.displayName = "FlipView"
