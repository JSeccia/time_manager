FROM elixir:latest
RUN mkdir /app
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
WORKDIR /app
RUN chmod +x /app/entrypoint.sh
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix deps.get
RUN mix compile --force
CMD ["/app/entrypoint.sh"]