<img src="https://repository-images.githubusercontent.com/319471557/ccbb6400-7803-11eb-8115-eae55d3ead83" alt="Docker + MSSQL" width="800" />

# Docker + Microsoft&reg; SQL Server 2019

This is **NOT** intended for production purposes. \
This is intended strictly for learning and/or development purposes only.

## Get Up & Running

[Docker Desktop](https://www.docker.com/products/docker-desktop) must installed and running on your computer (*Desktop Community* edition is perfectly fine) prior to following the steps below.

## After Docker Desktop Has Been Installed

Follow the steps outlined below to get the container up and running.

1. Clone [this repo](https://github.com/digitalminellc/docker-mssql.git) to your desktop
2. Launch your shell program and `cd` into the cloned directory
3. Modify the `setup.sql` file with your custom TSQL
4. Select one of the following options below

### Option 1: Use the `docker-compose.yml` File

1. Launch your shell program and `cd` into the cloned directory
2. Run the following command:

  ```bash
  docker-compose up
  ```

Docker will then begin to do its thing.

### Option 2: Build Your Own Image

1. Launch your shell program and `cd` into the cloned directory
2. Modify the `Dockerfile` as you desire
3. Run the following command:

  ```bash
  docker build -t yourname/yourapp .
  ```

4. Start a new container using `docker run`

  ```bash
  docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=5trongP@55w0rd' -p 5533:1433 --name your-container-name -d yourname/yourapp
  ```

**Note:** MSSQL passwords must be at least eight (8) characters long, contain upper case, lower case, and digits.

## Stopping The Container

To stop the container, follow these steps:

1. Open the shell window where the program is running
2. On MacOS, use `<control>+C`
3. On Windows, use `<⌘>+C`

OR

1. Launch your shell program and `cd` into the cloned directory
2. Run the following command:

  ```bash
  docker-compose down
  ```

## Microsoft `SQL Server in Docker` Documentation

* [Microsoft Docker Hub](https://hub.docker.com/u/microsoft)
* [Microsoft SQL Server in Docker Github Repo](https://github.com/Microsoft/mssql-docker)
* [Quickstart: Run SQL Server container images with Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
* [Best Practices (Deploy and connect to SQL Server Docker containers)](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment)

## Issues

Please submit issues to <https://github.com/digitalminellc/docker-mssql/issues>

## License

[MIT](LICENSE)
