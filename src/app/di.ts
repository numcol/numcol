import { GameFactory } from "@numcol/domain"
import { RandomGameFactory } from "@numcol/infra"
import { ContainerBuilder } from "diod"

export const builder = new ContainerBuilder()
builder.register(GameFactory).use(RandomGameFactory)
