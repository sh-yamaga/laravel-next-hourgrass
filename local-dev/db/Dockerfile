FROM postgres:17-bullseye

ENV TZ Asia/Tokyo

ENV POSTGRES_DB "hourgrass"
ENV POSTGRES_USER "postgres"
ENV POSTGRES_PASSWORD "postgres"

RUN chown -R postgres:postgres /var/lib/postgresql/data/ /docker-entrypoint-initdb.d