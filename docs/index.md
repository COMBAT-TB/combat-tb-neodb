# combatTB Database

[![Build Status](https://travis-ci.org/COMBAT-TB/combat-tb-db.svg?branch=master)](https://travis-ci.org/COMBAT-TB/combat-tb-db) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1219127.svg)](https://doi.org/10.5281/zenodo.1219127)

[![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-db/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-db) [![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-dc/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-dc) [![Docker Repository on Quay](https://quay.io/repository/combat-tb/combattb-es/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/combattb-es)

This repository builds the combatTB Neo4j Graph database backed by Elasticsearch

## Up and Running

### Deploy to OpenStack using `terraform`

To deploy the COMBAT-TB database to OpenStack, kindly head to [deployment README](./deploy/openstack/).

### Locally using `docker` and `docker-compose`

Assuming you have [docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/overview/) installed.

```sh
$ git clone https://github.com/COMBAT-TB/combat-tb-db.git
$ cd combat-tb-db
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

Sample queries:

- Search for `katg` gene.

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

- Search for variants in `katg` gene.

```sh
$ curl -XGET 'http://localhost:9200/variant/_search?q=katg' | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1712  100  1712    0     0  99091      0 --:--:-- --:--:-- --:--:--   98k
{
  "took": 8,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 330,
    "max_score": 1.3146203,
    "hits": [
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35757",
        "_score": 1.3146203,
        "_source": {
          "consequence": "TG1668T",
          "pos": "2154444",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35852",
        "_score": 1.3146203,
        "_source": {
          "consequence": "GA1092G",
          "pos": "2155020",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35819",
        "_score": 1.3146203,
        "_source": {
          "consequence": "GC1038G",
          "pos": "2155074",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35983",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Ser700Pro",
          "pos": "2154014",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "33546",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Leu634Phe",
          "pos": "2154212",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "36040",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Gly593Asp",
          "pos": "2154334",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "33547",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Ala574Val",
          "pos": "2154391",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35966",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Asp573Asn",
          "pos": "2154395",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "35873",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Ala550Asp",
          "pos": "2154463",
          "gene": "katG",
          "drug": "isoniazid"
        }
      },
      {
        "_index": "variant",
        "_type": "Variant",
        "_id": "36041",
        "_score": 1.3146203,
        "_source": {
          "consequence": "Gln525Pro",
          "pos": "2154538",
          "gene": "katG",
          "drug": "isoniazid"
        }
      }
    ]
  }
}
```
