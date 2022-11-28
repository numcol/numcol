import type { NativeStackScreenProps } from "@react-navigation/native-stack"

export const enum Routes {
	Home = "Home",
	Languages = "Languages",
}

export type RootStackParamList = {
	Home: undefined
	Languages: undefined
}

export type ScreenProps<T extends keyof RootStackParamList> =
	NativeStackScreenProps<RootStackParamList, T>
