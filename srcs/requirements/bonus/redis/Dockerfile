# Use Alpine Linux version 3.20 as the base image
FROM alpine:3.20

# Update and upgrade Alpine packages
# Install Redis without caching
# Modify Redis configuration to allow external connections
# Set Redis maximum memory limit to 20MB
# Configure Redis to use allkeys-lru eviction policy
RUN apk update && apk upgrade && \
    apk add --no-cache redis && \
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis.conf && \  
    sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g"  /etc/redis.conf && \  
    echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf

# Expose port 6379 for Redis connections
EXPOSE 6379

# Start Redis with the specified configuration file
CMD [ "redis-server" , "/etc/redis.conf" ]
