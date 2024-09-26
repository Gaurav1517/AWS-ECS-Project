FROM public.ecr.aws/ubuntu/ubuntu:latest

# Update and install required packages in one RUN command to reduce the number of layers
RUN apt-get update && \
    apt-get install -y apache2 zip unzip apache2-utils curl && \
    apt-get clean

# Set the working directory
WORKDIR /var/www/html

# Download the web template zip file using curl
RUN curl -o little-fashion.zip https://www.free-css.com/assets/files/free-css-templates/download/page296/little-fashion.zip

# Unzip and move the files
RUN unzip little-fashion.zip && \
    cp -rvf 2127_little_fashion/* . && \
    rm -rf little-fashion.zip 2127_little_fashion

# Expose port 80 and set the default command to run Apache
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
