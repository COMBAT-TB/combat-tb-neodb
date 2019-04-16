# Using docker

Local installation using `docker` and `docker-compose`

**Prerequisites**

- [docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/overview/)

Assuming you have [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/overview/) installed.

```sh
$ git clone https://github.com/COMBAT-TB/combat-tb-db.git
$ cd combat-tb-db
$ docker-compose up --build -d
Building
```

The above command will build the combatTB NeoDB Graph database backed by Elasticsearch.
Once the server is running, it can be queried by going to the web interface on [http://localhost:7474](http://0.0.0.0:7474).

To view the schema, run:

```java
call db.schema.visualization
```

## Standalone installation

Download and extract the latest release of Neo4j from the [Neo4j Download Center](https://neo4j.com/download-center/#releases) and follow the relevant installation instructions from the [operators manual](https://neo4j.com/docs/operations-manual/current/installation/).

Run Neo4j as a background process:

```sh
$ cd ~/Downloads/neo4j-community-3.5.4
$ bin/neo4j start
```

and visit [http://localhost:7474](http://localhost:7474) in your web browser.

Connect using the username `neo4j` with default password `neo4j`. **You'll then be prompted to change the password.**

### Download, extract, and load COMBAT-TB NeoDB

Stop Neo4j

```sh
$ pwd
# $HOME/Downloads/neo4j-community-3.5.4
$ bin/neo4j stop
Stopping Neo4j.. stopped
```

Allow a store upgrade in case the current version of the database starts against an older store version.

```sh
$ export NEO4J_dbms_allow__format__migration=true
```

Allow an upgrade in case the current version of the database starts against an older version.

```sh
$ export NEO4J_dbms_allow__upgrade=true
```

Download and extract the [COMBAT-TB NeoDB](https://zenodo.org/record/1421060/files/gff2neo_db_data.tar.bz2?download=1)

```sh
$ pwd
# $HOME/Downloads/neo4j-community-3.5.4
$ tar -xjvf ~/Downloads/gff2neo_db_data.tar.bz2
$ cp -R ~/Downloads/databases/ data/
```

Start Neo4j

```sh
$ pwd
# $HOME/Downloads/neo4j-community-3.5.4
$ bin/neo4j start
```

and visit [http://localhost:7474](http://localhost:7474) in your web browser.

To view the schema, run:

```java
call db.schema.visualization
```
