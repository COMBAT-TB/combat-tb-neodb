# Installation

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

```cypher
call db.schema
```
