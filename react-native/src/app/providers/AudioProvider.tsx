import { createContext, ReactNode, useContext } from "react"

export type AudioObject = {
	play: () => Promise<void>
}

export const fallbackAudioObject: AudioObject = {
	play: () => Promise.resolve(),
}

export const enum Audios {
	GameBackground = "gameBackground",
}

interface AudioContextProps {
	audios: Record<Audios, AudioObject>
}

const AudioContext = createContext<AudioContextProps>({
	audios: {
		gameBackground: fallbackAudioObject,
	},
})

interface AudioProviderProps {
	children: ReactNode
	audios: Record<Audios, AudioObject>
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
