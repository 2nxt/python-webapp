# Base image
FROM ubuntu

# Set the working directory
WORKDIR /app

# Copy the Python requirements file
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip mariadb-server vim libmariadb-dev

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the Python script to the working directory
COPY . .

# Configure MySQL server and set password
RUN sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
    echo 'skip-networking' >> /etc/mysql/mariadb.conf.d/50-server.cnf && \
    service mariadb start && \
    sleep 10 && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'mysql';" && \
    mysql -u root -pmysql -e "FLUSH PRIVILEGES;"

# Expose port
EXPOSE 8080

# Start MySQL server and run the Python script
CMD service mariadb start && python3 app.py
