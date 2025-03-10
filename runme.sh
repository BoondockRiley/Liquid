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

echo "*** Setting up dvdrental schema..."
docker exec -it postgres-dev psql -U postgres -a -c "CREATE SCHEMA dvdrental AUTHORIZATION postgres;"
docker exec -it postgres-qa psql -U postgres -a -c "CREATE SCHEMA dvdrental AUTHORIZATION postgres;"
docker exec -it postgres-prod psql -U postgres -a -c "CREATE SCHEMA dvdrental AUTHORIZATION postgres;"

echo "*** Done!"
