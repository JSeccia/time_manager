FROM elixir:latest
ENV MIX_ENV=prod
ENV PORT=4000
RUN mkdir /app
ENV PGDATA=/var/lib/postgresql/foobar
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
WORKDIR /app
RUN chmod +x /app/entrypoint.sh
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix deps.get
RUN mix do compile, release
EXPOSE ${PORT}
CMD ["/app/entrypoint.sh"]