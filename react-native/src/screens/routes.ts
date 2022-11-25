import type { NativeStackScreenProps } from "@react-navigation/native-stack"

export const enum Routes {
	Home = "Home",
	Settings = "Settings",
}

export type RootStackParamList = {
	Home: undefined
	Settings: undefined
}

export type ScreenProps<T extends keyof RootStackParamList> =
	NativeStackScreenProps<RootStackParamList, T>
