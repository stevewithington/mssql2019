# https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment
# https://hub.docker.com/_/microsoft-mssql-server
# https://github.com/twright-msft/mssql-node-docker-demo-app
FROM mcr.microsoft.com/mssql/server:2019-latest

# LABEL maintainer="steve@digitalmine.com"
# LABEL gitrepo="https://github.com/digitalminellc/docker-mssql"
# LABEL dockerrepo="https://hub.docker.com/r/digitalmine/docker-mssql"

# Make sure we're the `root` user for `apt-get`
USER root

# Install dos2unix
RUN apt-get -y update && \
      apt-get install -y dos2unix

# Create a `build` directory
RUN mkdir -p /usr/build
WORKDIR /usr/build

# Copy `build` directory to container
COPY ./build /usr/build

RUN dos2unix *

# Grant permissions for our scripts to be executable
RUN chmod -R +x /usr/build

# Expose Default SQL Server TCP/Port
EXPOSE 1433

# Switch to the `mssql` user to run ENTRYPOINT scripts
USER mssql

# Will be executed when the contianer first starts up
ENTRYPOINT ["/bin/bash","./entrypoint.sh"]
