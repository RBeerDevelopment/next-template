#!/bin/bash
bun i

# Prompt the user for the database name
echo "Please enter the database name:"
read db_name

# Check if the database name was provided
if [ -z "$db_name" ]; then
    echo "Error: Database name is required"
    exit 1
fi

# Run the Turso commands
echo "Creating database: $db_name"
turso db create "$db_name"
echo "Storing database URL in .env"
printf "\TURSO_CONNECTION_URL=$(turso db show $db_name --url)" >> .env
echo "Creating database token:"
printf "\TURSO_AUTH_TOKEN=$(turso db tokens create $db_name | grep ey)" >> .env

echo "Setup completed successfully!"