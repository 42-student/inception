# Use Alpine Linux version 3.20 as the base image (lightweight and secure)
FROM alpine:3.20

# Define build arguments for database configuration
ARG DB_NAME \
    DB_USER \
    DB_PASS

# Update package list and install MariaDB server & client
RUN apk update && apk add --no-cache mariadb mariadb-client

# Configure MariaDB server
# Create directory for MySQL daemon
# Set permissions to allow access
# Begin MySQL configuration
# Avoid DNS resolution caching issues
# Disable DNS host resolution for performance
# Allow connections from any address
# Write configuration to MySQL config file
# Ensure networking is enabled
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# Initialize the MySQL database directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose port 3306 to allow MySQL connections
EXPOSE 3306

# Copy the database initialization script into the container
COPY requirements/mariadb/conf/create_db.sh .

# Run the database initialization script and then remove it
RUN sh create_db.sh && rm create_db.sh

# Set the user to mysql for better security
USER mysql

# Start MariaDB server with reduced logging
CMD ["/usr/bin/mysqld", "--skip-log-error"]
