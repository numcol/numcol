import { Button } from "@numcol/ds"
import { useTranslation } from "@numcol/infra"
import { memo, useCallback } from "react"
import { useSound } from "../../../hooks/useSound"
import { useSettings } from "../../../providers/SettingsProvider"

export const SoundButton = memo(() => {
	const { t } = useTranslation()
	const { audio, toggleAudio } = useSettings()
	const { click } = useSound()

	const onPress = useCallback(() => {
		void click.play()
		toggleAudio()
	}, [click, toggleAudio])

	return (
		<Button
			onPress={onPress}
			color={Button.Color.Blue}
			fixedHeight
			icon={audio ? "volume-up" : "volume-mute"}
		>
			{t("sound")}
		</Button>
	)
})

SoundButton.displayName = "SoundButton"
