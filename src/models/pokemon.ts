import { z } from 'zod';

const type = z.object({
  name: z.string(),
  doubleDamageFrom: z.array(z.number().min(1)).optional(),
  doubleDamageTo: z.array(z.number().min(1)).optional(),
  halfDamageFrom: z.array(z.number().min(1)).optional(),
  halfDamageTo: z.array(z.number().min(1)).optional(),
  noDamageFrom: z.array(z.number().min(1)).optional(),
  noDamageTo: z.array(z.number().min(1)).optional(),
  moveDamageClassId: z.number().min(1).optional(),
});

const move = z.object({
  name: z.string(),
});

const stat = z.object({
  name: z.string(),
});

export const pokemon = z.object({
  name: z.string(),
  order: z.number().min(1),
  weight: z.number(),
  height: z.number(),
  baseExperience: z.number(),
  baseHappiness: z.number(),
  isDefault: z.boolean(),
  captureRate: z.number(),
  evolutionChain: z.number().optional(),
  evolvesFrom: z.number().optional(),
  evolvesTo: z.number().optional(),
  flavorText: z.string(),
  genus: z.string(),
  types: z.array(type),
  moves: z.array(move),
  stats: z.array(stat),
});

export type PokemonDTO = z.TypeOf<typeof pokemon>;
