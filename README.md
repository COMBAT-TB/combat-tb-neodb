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

### Neo4j

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.
To view the schema, run:

```
call db.schema
```

Sample query:

```
MATCH (g:Gene)-[r:ENCODES]->(p:Protein) RETURN g.name as gene, p.name as protein LIMIT 25
```

### Elasticsearch

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
100   450  100   450    0     0  58946      0 --:--:-- --:--:-- --:--:-- 64285
{
  "took": 5,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 2,
    "max_score": 3.870527,
    "hits": [
      {
        "_index": "gene",
        "_type": "Gene",
        "_id": "16844",
        "_score": 3.870527,
        "_source": {
          "uniquename": "Rv1908c",
          "name": "katG",
          "description": [
            "Catalase-peroxidase-peroxynitritase T KatG"
          ]
        }
      },
      {
        "_index": "gene",
        "_type": "Gene",
        "_id": "4195",
        "_score": 3.649168,
        "_source": {
          "uniquename": "MT1959",
          "name": "katG",
          "description": [
            "catalase-peroxidase"
          ]
        }
      }
    ]
  }
}
```
