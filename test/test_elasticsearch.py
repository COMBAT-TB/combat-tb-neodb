import pytest
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search

es_client = Elasticsearch()


@pytest.mark.skip(reason="Zenodo is having issues.")
def test_indices():
    """
    Get the number of indices
    """
    indices = len(es_client.indices.get_alias("*"))
    assert indices == 13


@pytest.mark.skip(reason="Zenodo is having issues.")
def test_es_search():
    """
    Multimatch search for the KatG gene.
    """
    search = Search(using=es_client, index="_all") \
        .query("multi_match", query="katg", fields=['name', 'uniquename'])
    response = search.execute()
    assert response.hits.total == 2
