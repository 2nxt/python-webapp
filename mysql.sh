#!/bin/bash

# MySQL configuration
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="mysql"
DB_NAME="lab"

# SQL statements
SQL_CREATE_DB="CREATE DATABASE IF NOT EXISTS $DB_NAME;"
SQL_USE_DB="USE $DB_NAME;"
SQL_CREATE_TABLE="CREATE TABLE IF NOT EXISTS color (id INT AUTO_INCREMENT PRIMARY KEY, color_name VARCHAR(50));"
SQL_INSERT_DATA="INSERT INTO color (color_name) VALUES ('green'), ('blue'), ('pink');"

# Execute SQL statements
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -e "$SQL_CREATE_DB"
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "$SQL_CREATE_TABLE"
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "$SQL_INSERT_DATA"

echo "MySQL setup completed."