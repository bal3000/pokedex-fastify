import { FastifyInstance, RouteShorthandOptions } from 'fastify';
import { z } from 'zod';

import { PokemonDTO, pokemon } from '../models/pokemon';

const response = z.number().min(1);

type ResponseSchema = z.TypeOf<typeof response>;

const routeOpts: RouteShorthandOptions = {
  schema: {
    body: pokemon,
    response: {
      201: response,
    },
  },
};

export default async function createPokemonRoute(server: FastifyInstance) {
  server.post<{ Body: PokemonDTO }>(
    '/pokemon',
    routeOpts,
    async (request, reply): Promise<ResponseSchema> => {
      const pokemon = await server.prisma.pokemon.create({
        data: { ...request.body },
      });
      return reply.code(201).send(1);
    }
  );
}
