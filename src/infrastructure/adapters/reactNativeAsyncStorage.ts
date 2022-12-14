import { Logger } from "@numcol/app"
import { Storage } from "@numcol/ui"
import AsyncStorage from "@react-native-async-storage/async-storage"

export class ReactNativeAsyncStorage implements Storage {
	public constructor(private readonly logger: Logger) {}

	public async setItem(key: string, value: string): Promise<void> {
		try {
			await AsyncStorage.setItem(key, value)
		} catch (e) {
			const err = e instanceof Error ? e : new Error(String(e))
			this.logger.error(err)
		}
	}

	public async getItem(key: string): Promise<string | undefined> {
		try {
			const value = await AsyncStorage.getItem(key)
			return value ?? undefined
		} catch (e) {
			const err = e instanceof Error ? e : new Error(String(e))
			this.logger.error(err)
			return undefined
		}
	}
}
