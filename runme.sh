echo "*** Removing old postgres containers (if they exist)..."
docker rm -f postgres-dev postgres-qa postgres-prod

echo "*** Pulling latest postgres image..."
docker pull postgres

echo "*** Starting PostgreSQL containers..."
docker run --name postgres-dev -p 5433:5432 -e POSTGRES_PASSWORD=secret -d postgres
docker run --name postgres-qa -p 5434:5432 -e POSTGRES_PASSWORD=secret -d postgres
docker run --name postgres-prod -p 5435:5432 -e POSTGRES_PASSWORD=secret -d postgres

echo "*** Waiting for PostgreSQL to be ready..."
sleep 10

echo
echo "*** Setting up dvdrental schema on postgres-dev ... "
docker exec \
    -it \
    postgres-dev \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

echo "*** Setting up dvdrental schema on postgres-qa ... "
docker exec \
    -it \
    postgres-qa \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"

echo "*** Setting up dvdrental schema on postgres-prod ... "
docker exec \
    -it \
    postgres-prod \
    /bin/bash -c "psql -U postgres -a -c 'CREATE SCHEMA dvdrental AUTHORIZATION postgres;'"