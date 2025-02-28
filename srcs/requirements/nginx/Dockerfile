# Use Alpine Linux version 3.20 as the base image (lightweight and secure)
FROM alpine:3.20  

# Update package list, upgrade existing packages, and install Nginx without caching unnecessary files
RUN apk update && apk upgrade && apk add --no-cache nginx

# Expose port 443 to allow HTTPS traffic
EXPOSE 443

# Start Nginx in the foreground (prevents container from exiting)
CMD ["nginx", "-g", "daemon off;"]
