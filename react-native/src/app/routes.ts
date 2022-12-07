import type { NativeStackScreenProps } from "@react-navigation/native-stack"

export const enum Routes {
	Home = "Home",
	Languages = "Languages",
	CountDown = "CountDown",
	Game = "Game",
}

export type RootStackParamList = {
	Home: undefined
	Languages: undefined
	CountDown: undefined
	Game: undefined
}

export type ScreenProps<T extends keyof RootStackParamList> =
	NativeStackScreenProps<RootStackParamList, T>
