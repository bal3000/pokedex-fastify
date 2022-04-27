import buildServer from './server';

const server = buildServer();

const start = async () => {
  try {
    await server.listen(3000);
    server.log.info(`Server listening on ${server.server.address()}`);
  } catch (err) {
    server.log.error(err);
    process.exit(1);
  }
};

start();
