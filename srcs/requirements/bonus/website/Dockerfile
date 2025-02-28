# Use Alpine Linux version 3.20 as the base image
FROM alpine:3.20

# Update, upgrade, and install Nginx without caching
RUN apk update && apk upgrade && apk add --no-cache nginx

# Create Nginx configuration file with a custom port
RUN echo "server {" > /etc/nginx/http.d/default.conf && \
    echo "listen 9090;" >> /etc/nginx/http.d/default.conf && \
    echo "root    /var/www;" >> /etc/nginx/http.d/default.conf && \
    echo "location / {" >> /etc/nginx/http.d/default.conf && \
    echo "    try_files \$uri /index.html;" >> /etc/nginx/http.d/default.conf && \
    echo "    }" >> /etc/nginx/http.d/default.conf && \
    echo "}" >> /etc/nginx/http.d/default.conf

# Copy website files into the Nginx root directory
COPY requirements/bonus/website/conf/* /var/www/

# Expose only port 9090 for HTTP traffic
EXPOSE 9090

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
