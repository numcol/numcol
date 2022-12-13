import { CreateGameUseCase, GetGameUseCase, ReplyUseCase } from "@numcol/app"
import { GameRepository } from "@numcol/domain"
import { Logger, Storage } from "@numcol/ui"
import { ContainerBuilder } from "diod"
import {
	InMemoryGameRepository,
	ReactNativeAsyncStorage,
	ReactNativeLogger,
} from "./adapters"

export const builder = new ContainerBuilder()
builder.register(GameRepository).use(InMemoryGameRepository).asSingleton()
builder.register(Logger).use(ReactNativeLogger)
builder
	.register(Storage)
	.use(ReactNativeAsyncStorage)
	.withDependencies([Logger])
builder.registerAndUse(CreateGameUseCase).withDependencies([GameRepository])
builder.registerAndUse(GetGameUseCase).withDependencies([GameRepository])
builder.registerAndUse(ReplyUseCase).withDependencies([GameRepository])
