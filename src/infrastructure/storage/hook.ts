import AsyncStorage from "@react-native-async-storage/async-storage"
import { useCallback } from "react"
import { useLogger } from "../logger"

export const useStorage = (): {
	setItem: (key: string, value: string) => Promise<void>
	getItem: (key: string) => Promise<string | undefined>
} => {
	const { error } = useLogger()
	const setItem = useCallback(
		async (key: string, value: string) => {
			try {
				await AsyncStorage.setItem(key, value)
			} catch (e) {
				const err = e instanceof Error ? e : new Error(String(e))
				error(err)
			}
		},
		[error],
	)

	const getItem = useCallback(
		async (key: string) => {
			try {
				const value = await AsyncStorage.getItem(key)
				return value ?? undefined
			} catch (e) {
				const err = e instanceof Error ? e : new Error(String(e))
				error(err)
				return undefined
			}
		},
		[error],
	)

	return { setItem, getItem }
}
