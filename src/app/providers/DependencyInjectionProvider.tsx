import { ContainerBuilder, Identifier } from "diod"
import { createContext, ReactNode, useContext } from "react"

const builder = new ContainerBuilder()
const container = builder.build({ autowire: false })

const DependencyInjectionContext = createContext<{
	get<T>(identifier: Identifier<T>): T
}>(container)

interface AudioProviderProps {
	children: ReactNode
	container: {
		get<T>(identifier: Identifier<T>): T
	}
}

export const DependencyInjectionProvider = ({
	children,
	container,
}: AudioProviderProps) => {
	return (
		<DependencyInjectionContext.Provider value={container}>
			{children}
		</DependencyInjectionContext.Provider>
	)
}

export const useService = <T,>(identifier: Identifier<T>): T => {
	const container = useContext(DependencyInjectionContext)
	return container.get(identifier)
}
