# :whale: combatTB Database

[![Build Status](https://travis-ci.org/COMBAT-TB/combatb-db.svg?branch=master)](https://travis-ci.org/COMBAT-TB/combatb-db) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1239572.svg)](https://doi.org/10.5281/zenodo.1239572)

This repo builds the combatTB Neo4j Graph database backed by Elasticsearch

## Up and Running

### Using [PWD](https://labs.play-with-docker.com/)

[![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-db/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-db) [![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-dc/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-dc) [![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-es/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-es)

Click the _Try in PWD_ button below to get 4 hours to try it out in the cloud.

- _[DockerHub](https://hub.docker.com/) account needed._

[![Try in PWD](https://cdn.rawgit.com/play-with-docker/stacks/cff22438/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/COMBAT-TB/combatb-db/dev/stack.yml)

### Using `docker-compose`

Assuming you have [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/overview/) installed.

```sh
$ docker-compose up --build -d
Building
```

#### Neo4j

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.
To view the schema, run:

```java
call db.schema
```

Sample query:

```java
MATCH (g:Gene)-[r:ENCODES]->(p:Protein) RETURN g.name as gene, p.name as protein LIMIT 25
```

#### Elasticsearch

Elasticsearch can be accessed on port `9200`, run the following to check the indices:

```sh
$ curl -XGET 'http://localhost:9200/_cat/indices'
yellow..
```

Sample query:

```sh
$ curl -XGET 'http://localhost:9200/gene/_search?q=katg' | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   380  100   380    0     0  65168      0 --:--:-- --:--:-- --:--:-- 76000
{
  "took": 2,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 1,
    "max_score": 2.4831636,
    "hits": [
      {
        "_index": "gene",
        "_type": "Gene",
        "_id": "10106",
        "_score": 2.4831636,
        "_source": {
          "biotype": "protein_coding",
          "uniquename": "Rv1908c",
          "name": "katG",
          "description": [
            "Catalase-peroxidase-peroxynitritase T KatG"
          ],
          "category": "virulence, detoxification, adaptation"
        }
      }
    ]
  }
}
```
