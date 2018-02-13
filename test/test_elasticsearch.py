import os
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search

es_client = Elasticsearch(hosts=[
    {'host': os.environ.get("DB", "localhost")},
])


def test_es_search():
    search = Search(using=es_client, index="_all") \
        .query("multi_match", query="katg", fields=['name', 'uniquename'])
    response = search.execute()
    assert response.hits.total == 2
