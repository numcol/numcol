import { useMemo } from "react"
import { AppAudios, mutedAudios, useAudio } from "../providers/AudioProvider"
import { useSettings } from "../providers/SettingsProvider"

export const useSound = () => {
	const { audio } = useSettings()
	const { audios } = useAudio()

	const sounds: AppAudios = useMemo(() => {
		if (audio) {
			return audios
		}

		return mutedAudios
	}, [audio, audios])

	return sounds
}
