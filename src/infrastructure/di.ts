import {
	CreateGameUseCase,
	GetGameUseCase,
	Logger,
	ReplyUseCase,
} from "@numcol/app"
import { DomainEventBus, GameRepository } from "@numcol/domain"
import { Storage } from "@numcol/ui"
import { ContainerBuilder } from "diod"
import {
	InMemoryGameRepository,
	ReactNativeAsyncStorage,
	ReactNativeLogger,
} from "./adapters"
import { EventEmitter3DomainEventBus } from "./adapters/eventEmitter3DomainEventBus"

export const builder = new ContainerBuilder()
builder
	.register(GameRepository)
	.use(InMemoryGameRepository)
	.withDependencies([DomainEventBus])
	.asSingleton()
builder.register(Logger).use(ReactNativeLogger)
builder
	.register(Storage)
	.use(ReactNativeAsyncStorage)
	.withDependencies([Logger])
builder.registerAndUse(CreateGameUseCase).withDependencies([GameRepository])
builder.registerAndUse(GetGameUseCase).withDependencies([GameRepository])
builder.registerAndUse(ReplyUseCase).withDependencies([GameRepository])
builder
	.register(DomainEventBus)
	.use(EventEmitter3DomainEventBus)
	.withDependencies([Logger])
	.asSingleton()
