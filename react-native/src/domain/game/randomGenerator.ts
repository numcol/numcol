import { Answer } from "./answer"
import { NumcolColor } from "./color"
import { NumcolNumber } from "./number"
import { Numcol } from "./numcol"

export const randomAnswer = (id: number) => new Answer(id, randomNumcol())

export const randomAnswers = (): Answer[] => {
	const answers: Answer[] = []

	for (let i = 1; i <= 36; i++) {
		answers.push(randomAnswer(i))
	}

	return answers
}

export const randomQuestion = (answers: Answer[]) => randomItem(answers).numcol

const randomNumcol = () => new Numcol(randomColor(), randomNumber())

const randomColor = () => randomStringEnum(NumcolColor)

const randomNumber = () => randomStringEnum(NumcolNumber)

const randomStringEnum = <T extends string>(anEnum: Record<string, T>): T =>
	randomItem(Object.values(anEnum))

const randomItem = <T>(items: T[]): T => {
	const randomIndex = Math.floor(Math.random() * items.length)
	return items[randomIndex] as T
}
