#!/bin/bash

# Step 1: Remove old postgres containers (if they exist)
echo "*** Removing old postgres containers (if they exist)..."
docker rm -f postgres-dev postgres-qa postgres-prod

# Step 2: Pull the latest postgres image
echo "*** Pulling latest postgres image..."
docker pull postgres

# Step 3: Start PostgreSQL containers
echo "*** Starting PostgreSQL containers..."
docker run --name postgres-dev -p 5433:5432 -e POSTGRES_PASSWORD=secret -d postgres
docker run --name postgres-qa -p 5434:5432 -e POSTGRES_PASSWORD=secret -d postgres
docker run --name postgres-prod -p 5435:5432 -e POSTGRES_PASSWORD=secret -d postgres

# Step 4: Wait for PostgreSQL to be ready
echo "*** Waiting for PostgreSQL to be ready..."
sleep 10

# Step 5: Copy the tables.sql file into the Docker container
echo "*** Copying tables.sql to the container..."
docker cp SQL/Tables.sql postgres-dev:/tmp/Tables.sql
docker cp SQL/Tables.sql postgres-qa:/tmp/Tables.sql


# Step 6: Create the schema in postgres-dev and run the tables.sql script using psql
docker exec -it postgres-dev bash -c "psql -U postgres -a -f /tmp/Tables.sql -c '\q'"

# Step 7: Confirm success or handle errors
if [ $? -eq 0 ]; then
  echo "Schema created and tables created successfully in postgres-dev."
else
  echo "Error occurred during schema creation or table creation in postgres-dev."
fi

# Step 6: Create the dvdrental schema in postgres-dev and run the tables.sql script using psql

docker exec -it postgres-qa bash -c "psql -U postgres -a -f /tmp/Tables.sql -c '\q'"

# Step 7: Confirm success or handle errors
if [ $? -eq 0 ]; then
  echo "Schema created and tables created successfully in postgres-qa."
else
  echo "Error occurred during schema creation or table creation in postgres-qa."
fi

docker exec -it postgres-prod psql -U postgres -a -c "CREATE SCHEMA dvdrental AUTHORIZATION postgres;"

echo "*** Done!"