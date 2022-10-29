FROM elixir:latest
RUN mkdir /app
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
WORKDIR /app
RUN mix local.hex --force
RUN mix do compile
CMD ["/app/entrypoint.sh"]