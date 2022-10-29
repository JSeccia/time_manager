FROM postgres:latest
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB time_manager
ENV PGDATA /var/lib/postgresql/data/pgdata
VOLUME c:/postgres/data:/var/lib/postgresql/
ENTRYPOINT ["docker-entrypoint.sh"]