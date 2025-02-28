# Use Alpine Linux version 3.20 as the base image
FROM alpine:3.20

# Define environment variables for Portainer version and configuration
ENV PORTAINER_VERSION=2.26.0 \
    PORTAINER_HOME=/var/lib/portainer

# Update and upgrade Alpine Linux, then install curl
RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl

# Download and extract Portainer binary
RUN curl -L https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar xzf portainer.tar.gz \
    && rm portainer.tar.gz

# Expose the necessary ports (8000 for Edge agent, 9443 for HTTPS access)
EXPOSE 8000 9443

# Start Portainer
CMD ["./portainer/portainer"]
