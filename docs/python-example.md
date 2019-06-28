# Python

[Neo4j](https://www.neo4j.com/) provides several interfaces for multiple programming languages including [Python](https://www.python.org/), a predominant language in bioinformatics.

The Neo4j community has contributed a range of driver options when it comes to [working with the database via Python](https://neo4j.com/developer/python/). These range from lightweight to comprehensive driver packages.

We are going to use a python package called [combattbmodel](https://github.com/COMBAT-TB/combattbmodel). We developed `combattbmodel` to model the Combat-TB-NeoDB schema using [py2neo](https://py2neo.org/v3/), a client library and toolkit for working with Neo4j from within Python applications and from the command line. This package enables bioinformaticians to interact with Combat-TB-NeoDB using pure Python.

To install `combattbmodel`, run:

```sh
$ pip install -i https://test.pypi.org/simple/ combattbmodel
...
```

The simplest way to try out a connection to Combat-TB-NeoDB is via the console. Once you have started a [local Combat-TB-NeoDB instance](https://combattb.org/combat-tb-neodb/installation/), open a new Python console and enter the following code:

```sh
>>> from py2neo import Graph
>>> graph = Graph(host='localhost', password='')
```

If you wish to use [https://neodb.sanbi.ac.za](https://neodb.sanbi.ac.za) instead of setting up a local instance, point `py2neo` to `neodb.sanbi.ac.za` with the `secure` param set to `True`.

```sh
>>> graph = Graph(host='neodb.sanbi.ac.za', password='', secure=True)
```

## Example Python Queries

### Exploring Combat-TB-NeoDB

#### Node labels currently defined

The set of node labels currently defined within the graph.

```sh
>>> graph.node_labels
frozenset({'Organism', 'GOTerm', 'Pathway', 'Variant', 'TRna', 'PseudoGene', 'CallSet', 'Gene', 'RRna', 'DbXref', 'Protein', 'NCRna', 'Drug', 'InterProTerm', 'Publication', 'VariantSet', 'Author', 'Chromosome', 'Location', 'MRna', 'CDS'})
>>>
```

#### Relationship types currently defined

The set of relationship types currently defined within the graph.

```sh
>>> graph.relationship_types
frozenset({'INTERACTS_WITH', 'PUBLISHED_IN', 'PART_OF', 'LOCATED_AT', 'OCCURS_IN', 'BELONGS_TO', 'ASSOCIATED_WITH', 'INVOLVED_IN', 'CAPABLE_OF', 'RESISTANT_TO', 'HAS_VARIANT', 'IS_A', 'XREF', 'ENCODES', 'REGULATES', 'LOCATED_ON', 'DERIVES_FROM', 'CALL_SET', 'WROTE', 'TARGET'})
>>>
```

#### Open Neo4j browser

Open a page pointing at the Neo4j browser for this graph.

```sh
>>> graph.open_browser()
>>>
```

### Querying Combat-TB-NeoDB

#### Finding known variants from a list of genes of interest

Find known variants in `katG` and `gyrB` genes

```sh
>>> from combattbmodel.vcfmodel import Variant
>>> genes = ['katG', 'gyrB']
>>> for v in Variant.select(graph):
...     for g in v.occurs_in:
...         if g.name in genes:
...             print(g.name, v.pos, v.consequence)
...
gyrB 6620 Asp461Asn
```

Alternatively:

```sh
>>> for gene in genes:
...     for v in list(Variant.select(graph).where(f”_.gene=~’(?i).*{gene}.*’”)):
...         print(g.name, v.pos, v.consequence)
...
katG 2155168 Ser315Thr
```
