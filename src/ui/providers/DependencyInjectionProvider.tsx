import { createContext, ReactNode, useContext, useMemo } from "react"

const container = {
	get: () => {
		throw new Error("DependencyInjectionContext must be initialized")
	},
}

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

	const service = useMemo(
		() => container.get(identifier),
		[container, identifier],
	)

	return service
}
