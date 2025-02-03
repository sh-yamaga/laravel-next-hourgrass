FROM postgres:17-bullseye

# DB_NAME
ENV POSTGRES_DB "hourgrass"

# User
ENV POSTGRES_PASSWORD "postgres"
ENV POSTGRES_USER "postgres"

# Timezone
ENV TZ Asia/Tokyo

RUN chown -R postgres:postgres /var/lib/postgresql/data/ /docker-entrypoint-initdb.d