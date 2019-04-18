# Cypher

Cypher is a declarative graph query language that allows for expressive and efficient querying and updating of the graph. Cypher is designed to be simple, yet powerful; highly complicated database queries can be easily expressed, enabling you to focus on your domain, instead of getting lost in database access.

## Example Queries

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.
To view the schema, run:

```java
call db.schema.visualization
```

### Find genes that encode proteins, limiting to results to 25

```java
MATCH (g:Gene)-[r:ENCODES]->(p:Protein) RETURN g.name as gene, p.name as protein LIMIT 25
```

### Which genes encode a protein that interacts with a known drug target

```java
MATCH(gene)-[:ENCODES]-(p1:Protein)-[:INTERACTS_WITH]-(p2:Protein)-[:TARGET]-(drug:Drug) RETURN *
```

### Find a drugs that targets a set of proteins

```java
MATCH(p:Protein)-[:TARGET]-(drug) WITH drug, count(p) AS ProteinSetSize, collect(protein.uniquename) AS ProteinSet
WHERE ProteinSetSize > 1 RETURN drug.name AS DrugName, drug.accession AS DrugAcc, ProteinSet, ProteinSetSize ORDER BY ProteinSetSize DESC
```
