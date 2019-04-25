# Cypher

Cypher is a declarative graph query language that allows for expressive and efficient querying and updating of the graph. Cypher is designed to be simple, yet powerful; highly complicated database queries can be easily expressed, enabling you to focus on your domain, instead of getting lost in database access.

## Explore NeoDB

### Label counts

In Neo4j, node types are called labels. The following query counts the number of nodes per label.

```cypher
MATCH(node)
RETURN head(labels(node)) AS label,
  count(*) AS count
ORDER BY count DESC
```

### Relationship type counts

The following query counts the number of relationships per type

```cypher
MATCH()-[rel]->()
RETURN type(rel) AS rel_type,
  count(*) AS count
ORDER BY count DESC
```

### Random relationships

The following query retrieves a random relationship of each
type. The query goes through every relationship and thus may
take several seconds.

```cypher
MATCH()-[rel]->() WITH type(rel) AS rel_type, collect(rel) AS rels
WITH rels[toInteger(rand() * size(rels))] AS rel
RETURN startNode(rel), rel, endNode(rel)
```

## Querying NeoDB

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.
To view the schema, run:

```cypher
call db.schema.visualization
```

### Genes that encode protein, limiting to results to 25

The following query finds genes that encode protein.

```cypher
MATCH (g:Gene)-[r:ENCODES]->(p:Protein)
RETURN g.name as gene, p.name as protein LIMIT 25
```

### Genes that encode a protein that interacts with a known drug target

The following query finds proteins that interact with known drug targets.

```cypher
MATCH(gene)-[:ENCODES]-(p1:Protein)-[:INTERACTS_WITH]-(p2:Protein)-[:TARGET]-(drug:Drug)
RETURN *
```

### Drugs that targets multiple proteins

The following query finds drugs that target multiple proteins.

```cypher
MATCH(p:Protein)-[:TARGET]-(drug) WITH drug, count(p) AS ProteinSetSize,
    collect(protein.uniquename) AS ProteinSet
WHERE ProteinSetSize > 1
RETURN drug.name AS DrugName, drug.accession AS DrugAcc, ProteinSet, ProteinSetSize
ORDER BY ProteinSetSize DESC
```

### Proteins targeted by multiple drugs

The following query finds proteins targeted by multiple drugs.

```cypher
MATCH(drug:Drug)-[:TARGET]-(protein) WITH protein, count(drug) as DrugCount,
  collect(drug.name) as DrugNames, protein.uniquename as Proteins,
  protein.function as ProteinFunctions
WHERE DrugCount > 1
RETURN Proteins, ProteinFunctions, DrugCount, DrugNames ORDER BY DrugCount DESC
```
