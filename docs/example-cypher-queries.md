# Cypher

Cypher is a declarative graph query language that allows for expressive and efficient querying and updating of the graph. Cypher is designed to be simple, yet powerful; highly complicated database queries can be easily expressed, enabling you to focus on your domain, instead of getting lost in database access.

Point your browser to [localhost:7474](http://0.0.0.0:7474) to access the Neo4j browser.

On cold boot, Neo4j has nothing cached yet, and needs to go to disk for all records.
Once records are cached, you will see greatly improved performance.
One technique that is widely employed is to “warm the cache”.

To warm the cache to improve performance from cold start, run:

```cql
CALL apoc.warmup.run
```

This will load all nodes and relationships into memory.

To view the schema, run:

```cql
call db.schema.visualization
```

## Example Cypher Queries

### Exploring COMBAT-TB NeoDB

#### Label count

In Neo4j, node types are called labels. The following query counts the number of nodes per label.

```cql
MATCH(node)
RETURN head(labels(node)) AS label,
  count(*) AS count
ORDER BY count DESC
```

#### Relationship type count

The following query counts the number of relationships per type

```cql
MATCH()-[rel]->()
RETURN type(rel) AS rel_type,
  count(*) AS count
ORDER BY count DESC
```

#### Random relationships

The following query retrieves a random relationship of each
type. The query goes through every relationship and thus may
take several seconds.

```cql
MATCH()-[rel]->() WITH type(rel) AS rel_type, collect(rel) AS rels
WITH rels[toInteger(rand() * size(rels))] AS rel
RETURN startNode(rel), rel, endNode(rel)
```

### Querying COMBAT-TB NeoDB

#### Genes that encode protein, limiting to results to 25

The following query finds genes that encode protein.

```cql
MATCH(g:Gene)-[r:ENCODES]->(p:Protein)
RETURN g.name as gene, p.name as protein LIMIT 25
```

#### Genes that encode a protein that interacts with a known drug target

The following query finds proteins that interact with known drug targets.

```cql
MATCH p=(gene:Gene)-[:ENCODES]-(p1:Protein)-[i:INTERACTS_WITH]-(p2:Protein)-[:TARGET]-(drug:Drug)
RETURN gene.name as Gene, i.score as Score, p2.uniquename as Interactor, drug.name as Drug
ORDER BY Score DESC
```

#### Find proteins that interact with a certain protein

The following query finds proteins that interact with a protein that has `O06295` as the uniquename or UniProtId.

```cql
MATCH p=(:Protein {uniquename:'O06295'})-[r:INTERACTS_WITH]-(:Protein)
RETURN p
```

#### Find the top 10 proteins that interact with a specific protein sorted by score

The following query finds the top 10 proteins that interact with a
protein that has `O06295` as the uniquename or UniProtId. We the return the score,
sorted in descending order, the UniProtID, and the ProteinName.

```cql
MATCH p=(protein)-[r:INTERACTS_WITH]-(:Protein {uniquename:'O06295'})
RETURN r.score as SCORE, protein.uniquename as UniProtID, protein.name as ProteinName
ORDER BY r.score DESC LIMIT 10
```

#### Drugs that targets multiple proteins

The following query finds drugs that target multiple proteins.

```cql
MATCH(p:Protein)-[:TARGET]-(drug) WITH drug, count(p) AS ProteinSetSize,
    collect(protein.uniquename) AS ProteinSet
WHERE ProteinSetSize > 1
RETURN drug.name AS DrugName, drug.accession AS DrugAcc, ProteinSet, ProteinSetSize
ORDER BY ProteinSetSize DESC
```

#### Proteins targeted by multiple drugs

The following query finds proteins targeted by multiple drugs.

```cql
MATCH(drug:Drug)-[:TARGET]-(protein) WITH protein, count(drug) as DrugCount,
  collect(drug.name) as DrugNames, protein.uniquename as Proteins,
  protein.function as ProteinFunctions
WHERE DrugCount > 1
RETURN Proteins, ProteinFunctions, DrugCount, DrugNames ORDER BY DrugCount DESC
```

#### Which proteins are likely to infer drug resistance (DR) if mutated

The following query finds proteins known to be associated with DR mutations

```cql
MATCH(d:Drug)--(:Variant)--(g)--(p:Protein)
RETURN distinct(p.name) as Protein, g.name as Gene, d.name as Drug
```

#### Which proteins are targeted by a specific drug (Isoniazid)

The following query finds proteins targeted by Isoniazid.

```cql
MATCH(drug:Drug {name: "Isoniazid"})-[r:TARGET]-(protein:Protein)
RETURN drug,r,protein
```

#### Which proteins are indirectly targeted by a specific drug

The following query finds proteins that are indirectly targeted by Rifampicin.

```cql
MATCH(drug:Drug {name: "Rifampicin"})--(:Variant)--(g:Gene)--(p:Protein) RETURN *
```
