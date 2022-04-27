import { FastifyInstance, RouteShorthandOptions } from 'fastify';
import { z } from 'zod';

const request = z.object({
  name: z.string(),
  type: z.string(),
});
const response = z.number().min(1);

type ResponseSchema = z.TypeOf<typeof response>;
type RequestSchema = z.TypeOf<typeof request>;

const routeOpts: RouteShorthandOptions = {
  schema: {
    body: request,
    response: {
      201: response,
    },
  },
};

export default async function createPokemonRoute(server: FastifyInstance) {
  server.post<{ Body: RequestSchema }>(
    '/pokemon',
    routeOpts,
    async (request, reply): Promise<ResponseSchema> => {
      const { name, type } = request.body;
      const pokemon = await server.prisma.pokemon.create({
        data: {
          name,
        },
      });
      return reply.code(201).send(1);
    }
  );
}
