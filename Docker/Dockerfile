FROM centos:7

RUN yum install -y epel-release centos-release-scl && \
    yum install -y epel-release

# Install Apache, MariaDB, and PHP dependencies
RUN yum update -y && \
    yum install -y wget httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json mod_ssl php-intl php-apcu

# Create a dedicated user for MariaDB
#RUN useradd -r -M mysql

# Change ownership of the MariaDB directory
RUN chown -R mysql:mysql /var/lib/mysql

# Download MediaWiki
RUN wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz

# Verify MediaWiki download (replace with your verification method)
# COPY verification_script.sh /tmp/verification_script.sh
# RUN chmod +x /tmp/verification_script.sh && /tmp/verification_script.sh mediawiki-1.41.1.tar.gz

# Extract MediaWiki
RUN tar -zxf mediawiki-1.41.1.tar.gz && mv mediawiki-1.41.1 /var/www/html

# Configure Apache
#COPY httpd.conf /etc/httpd/conf/httpd.conf

# Set ownership of MediaWiki directory
RUN chown -R apache:apache /var/www/html

# Start MariaDB using mysqld command
CMD ["mysqld"]

EXPOSE 80
