import { Logger, Storage } from "@numcol/ui"
import { GameFactory } from "@numcol/domain"
import { ContainerBuilder } from "diod"
import {
	RandomGameFactory,
	ReactNativeAsyncStorage,
	ReactNativeLogger,
} from "./adapters"

export const builder = new ContainerBuilder()
builder.register(GameFactory).use(RandomGameFactory)
builder.register(Logger).use(ReactNativeLogger)
builder
	.register(Storage)
	.use(ReactNativeAsyncStorage)
	.withDependencies([Logger])
