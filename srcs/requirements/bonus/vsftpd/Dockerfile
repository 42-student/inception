# Use Alpine Linux version 3.20 as the base image
FROM alpine:3.20

# Define build arguments for FTP username and password
ARG FTP_USR \
    FTP_PWD

# Update and upgrade Alpine packages
# Install vsftpd (FTP server) without caching
RUN apk update && apk upgrade && \
    apk add --no-cache vsftpd

# Create an FTP user with no login shell and set the password
RUN adduser -h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root

# Modify vsftpd configuration to allow local users to write files
RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf

# Additional configurations to allow writable chroot and enable passive mode
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf &&\
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

# Set working directory to /var/www
WORKDIR /var/www

# Expose port 21 for FTP connections
EXPOSE 21

# Start vsftpd using the specified configuration file
CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]
