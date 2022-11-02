FROM elixir:latest
ENV MIX_ENV=prod
ENV PORT=4000
RUN mkdir /app
COPY . /app
RUN apt-get update && \
  apt-get install -y postgresql-client
RUN  apt-get install -y dos2unix
RUN dos2unix /app/entrypoint.sh
WORKDIR /app
RUN chmod +x /app/entrypoint.sh
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix deps.get
RUN mix do compile, release
EXPOSE ${PORT}
CMD ["/app/entrypoint.sh"]