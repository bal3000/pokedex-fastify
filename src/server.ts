import Fastify, { FastifyInstance } from 'fastify';

import prismaPlugin from './plugins/prisma';
import createPokemonRoute from './routes/create-pokemon';

export default function buildServer() {
  const server: FastifyInstance = Fastify({ logger: true });

  server.register(prismaPlugin);

  // routes
  server.register(createPokemonRoute);

  server.log.info('Server is starting...');

  return server;
}
