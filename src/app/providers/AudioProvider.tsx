import { createContext, ReactNode, useContext } from "react"

export type AudioObject = {
	play: () => Promise<void>
	stop: () => Promise<void>
}

export const fallbackAudioObject: AudioObject = {
	play: () => Promise.resolve(),
	stop: () => Promise.resolve(),
}

export const enum Audios {
	HomeBackground = "homeBackground",
	GameBackground = "gameBackground",
	Click = "click",
	Wrong = "wrong",
	CountDown = "countDown",
	Start = "start",
}

export type AppAudios = Record<Audios, AudioObject>

interface AudioContextProps {
	audios: AppAudios
}

export const mutedAudios: AppAudios = {
	homeBackground: fallbackAudioObject,
	gameBackground: fallbackAudioObject,
	click: fallbackAudioObject,
	wrong: fallbackAudioObject,
	countDown: fallbackAudioObject,
	start: fallbackAudioObject,
}

const AudioContext = createContext<AudioContextProps>({
	audios: { ...mutedAudios },
})

interface AudioProviderProps {
	children: ReactNode
	audios: AppAudios
}

export const AudioProvider = ({ children, audios }: AudioProviderProps) => {
	return (
		<AudioContext.Provider
			value={{
				audios,
			}}
		>
			{children}
		</AudioContext.Provider>
	)
}

export const useAudio = (): AudioContextProps => {
	return useContext(AudioContext)
}
