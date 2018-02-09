import os
import pytest
from py2neo import Graph

graph = Graph(host=os.environ.get("DB", "localhost"), bolt=True,
              password=os.environ.get("NEO4J_PASSWORD", ""))


@pytest.mark.parametrize("test_input,expected", [
    ("MATCH (g:Gene) OPTIONAL MATCH ((g)<-[:PART_OF]-(t)) RETURN t.parent",
     type(None)),
    ("MATCH (g:Gene) OPTIONAL MATCH ((g)-[:LOCATED_AT]->(l)) RETURN l.fmax",
     type(None)),
    ("MATCH (g:Gene) OPTIONAL MATCH ((g)-[:ENCODES]->(p)) RETURN p.parent",
     type(None)),
])
def test_db_data(test_input, expected):
    result = graph.evaluate(test_input)
    assert isinstance(type(result), expected) is False
