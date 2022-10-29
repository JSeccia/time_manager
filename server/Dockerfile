FROM elixir:latest
RUN mkdir /app
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
WORKDIR /app
RUN mix deps.get --only $MIX_ENV
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix compile --force
CMD ["/app/entrypoint.sh"]