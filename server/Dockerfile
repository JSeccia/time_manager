FROM elixir:latest
ENV MIX_ENV=prod
ENV PORT=4000
RUN mkdir /app
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
WORKDIR /app
RUN chmod +x /app/entrypoint.sh
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix deps.get
RUN mix do compile, release
RUN mix phx.digest
RUN export DATABASE_URL=ecto://USER:PASS@HOST/database
EXPOSE ${PORT}
CMD ["/app/entrypoint.sh"]