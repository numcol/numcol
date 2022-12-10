import { Answer } from "./answer"

export const randomQuestion = (answers: Answer[]) => randomItem(answers).numcol

export const randomStringEnum = <T extends string>(
	anEnum: Record<string, T>,
): T => randomItem(Object.values(anEnum))

const randomItem = <T>(items: T[]): T => {
	const randomIndex = Math.floor(Math.random() * items.length)
	return items[randomIndex] as T
}
