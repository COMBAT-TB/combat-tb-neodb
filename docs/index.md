# Introduction

NeoDB is a free and open source integrated _M.tuberculosis (M.tb)_ ‘omics’ knowledge-base. NeoDB is based on Neo4j and enables researchers to execute complex federated queries by linking well-known, curated and widely used _M.tb_ data resources, and supplementary TB variants data from published literature. NeoDB was created by binding the labeled property graph model to a consensus-controlled ontology.

## Motivation

Tuberculosis (TB) is a significant global health threat, with one-third of the population infected with its causative agent *Mycobacterium tuberculosis (M.tb)*. Its mortality rate declined by 37% between 2000 and 2016, however, this period also saw an exponential growth in multi drug resistant TB (MDR-TB) and extensively drug resistant TB (XDR-TB) ([WHO., 2017](https://apps.who.int/iris/handle/10665/254762)). Globally, researchers have been responding with a plethora of heterogeneous TB databases with each focusing on different subsets of TB data and present limited options for data integration thus impeding the chances of integrative analysis. Although each database can provide answers to certain questions in its scope, it falls short in answering questions that require federated queries across multiple domains of biological knowledge.

The availability of different *M.tb* genomes and `omics` datasets require a computational platform that can seamlessly integrate a range of data. Integrating these fragmented biological resources is essential for the discovery of new associations between datasets or the validation of existing hypotheses. This necessitates effective and efficient management, storage, analysis and visualization of the data and results through development of novel and customized bioinformatics software tools and databases.

## NeoDB Graph Model

![neodb-browser-guide](./images/model.png)
