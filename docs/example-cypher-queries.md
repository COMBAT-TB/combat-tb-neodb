# Cypher

Cypher is a declarative graph query language that allows for expressive and efficient querying and updating of the graph. Cypher is designed to be simple, yet powerful; highly complicated database queries can be easily expressed, enabling you to focus on your domain, instead of getting lost in database access.

## Example Queries

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.
To view the schema, run:

```cypher
call db.schema
```

### Find all genes that encode proteins

```cypher
MATCH (g:Gene)-[r:ENCODES]->(p:Protein) RETURN g.name as gene, p.name as protein LIMIT 25
```
