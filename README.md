# :whale: combatTB Database

[![Build Status](https://travis-ci.org/COMBAT-TB/neo4j_db.svg?branch=master)](https://travis-ci.org/COMBAT-TB/neo4j_db)

combatTB Neo4j Database

This repo builds the combatTB Neo4j Graph database backed by Elasticsearch

## Up and Running

* Assuming you have [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/overview/) installed.

```sh
$ docker-compose up --build -d
Building
```

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.

Elasticsearch can be accessed on port `9200`, run the following to check the indices:

```sh
$ curl -XGET 'http://localhost:9200/_cat/indices'
yellow..
```
