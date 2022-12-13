import { Audio } from "expo-av"
import { useEffect, useState } from "react"
import {
	AudioObject,
	Audios,
	mutedAudios,
} from "../../ui/app/providers/AudioProvider"
import { ReactNativeLogger } from "../adapters"

const audios = { ...mutedAudios }

interface FetchedAudio {
	audio: Audios
	sound: Audio.SoundObject
	isLooping: boolean
}

const logger = new ReactNativeLogger()
const { error, debug } = logger

export const useFetchAudios = () => {
	const [loaded, setLoaded] = useState(false)

	useEffect(() => {
		async function fetchAudios() {
			const audioObjects = await Promise.allSettled<Promise<FetchedAudio>[]>([
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/POL-two-fat-gangsters-short.wav"),
					{
						isLooping: true,
						volume: 0.05,
					},
				).then((sound) => ({
					audio: Audios.HomeBackground,
					sound,
					isLooping: true,
				})),
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/POL-star-way-short.wav"),
					{
						isLooping: true,
						volume: 0.05,
					},
				).then((sound) => ({
					audio: Audios.GameBackground,
					sound,
					isLooping: true,
				})),
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/click.mp3"),
					{
						isLooping: false,
						volume: 1,
						shouldPlay: true,
					},
				).then((sound) => ({
					audio: Audios.Click,
					sound,
					isLooping: false,
				})),
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/wrong.mp3"),
					{
						isLooping: false,
						volume: 1,
					},
				).then((sound) => ({
					audio: Audios.Wrong,
					sound,
					isLooping: false,
				})),
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/countdown.mp3"),
					{
						isLooping: false,
						volume: 1,
					},
				).then((sound) => ({
					audio: Audios.CountDown,
					sound,
					isLooping: false,
				})),
				Audio.Sound.createAsync(
					// eslint-disable-next-line @typescript-eslint/no-var-requires
					require("../../../assets/audio/start.mp3"),
					{
						isLooping: false,
						volume: 1,
					},
				).then((sound) => ({
					audio: Audios.Start,
					sound,
					isLooping: false,
				})),
			])

			audioObjects.forEach((audio) => {
				if (audio.status === "rejected") {
					error(
						audio.reason instanceof Error
							? audio.reason
							: new Error(String(audio.reason)),
					)
					return
				}

				if (!audio.value.sound.status.isLoaded) {
					error(
						new Error(
							`Error loading audio: ${
								audio.value.sound.status.error ?? "unknown"
							}`,
						),
					)
					return
				}

				audios[audio.value.audio] = mapAudio(audio.value, { debug, error })
			})

			setLoaded(true)
		}

		void fetchAudios()
	}, [])

	return {
		audios,
		loaded,
	}
}

const mapAudio = (
	obj: FetchedAudio,
	args: {
		debug: (msg: string) => void
		error: (err: Error) => void
	},
): AudioObject => {
	const audioType = obj.audio
	const sound = obj.sound.sound
	const { debug, error } = args
	const play = obj.isLooping
		? () => sound.playAsync()
		: () => sound.playFromPositionAsync(0)

	return {
		play: () =>
			play()
				.then(() => {
					debug(`Audio played: ${audioType}`)
				})
				.catch(() => {
					error(new Error(`Audio can not be played: ${audioType}`))
				}),
		stop: () =>
			sound
				.stopAsync()
				.then(() => {
					debug(`Audio stopped: ${audioType}`)
				})
				.catch(() => {
					error(new Error(`Audio can not be stopped: ${audioType}`))
				}),
	}
}
