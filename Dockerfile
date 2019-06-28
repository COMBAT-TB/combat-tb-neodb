FROM neo4j:3.5-enterprise
LABEL Maintainer="thoba@sanbi.ac.za"

RUN apt-get update \
    && apt-get install -y wget openssl apt-utils zip unzip \
    && mkdir -p certificates/revoked \
    && mkdir -p certificates/trusted

ENV NEO4J_CONTRIB="https://github.com/neo4j-contrib"

RUN wget "${NEO4J_CONTRIB}/neo4j-graph-algorithms/releases/download/3.5.4.0/graph-algorithms-algo-3.5.4.0.jar" -P plugins/ \
    && wget "${NEO4J_CONTRIB}/neo4j-apoc-procedures/releases/download/3.5.0.4/apoc-3.5.0.4-all.jar" -P plugins/ 

COPY dc/plugins/* plugins/
COPY dc/*.html /

ENV NEO4J_AUTH=none \
    NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    # NEO4J_dbms_read__only=true \
    # NEO4J_dbms_shell_read__only=true \
    # NEO4J_browser_post__connect__cmd='config; play https://neodb.sanbi.ac.za/guide' \
    NEO4J_dbms_allow__upgrade=true

# Update the Neo4j Browser source to improve search results and add google Analytics
# https://github.com/hetio/hetionet/blob/master/hetnet/neo4j/docker/Dockerfile#L23
RUN cd /var/lib/neo4j/lib \
    && JAR_PATH=`ls neo4j-browser-*` \
    && HTML_PATH=browser/index.html \
    && unzip $JAR_PATH $HTML_PATH \
    && OLD='<title>Neo4j Browser</title>' \
    && NEW='<title>Combat-TB-NeoDB · Neo4j Browser</title>' \
    && sed --in-place "s|$OLD|$NEW|" $HTML_PATH \
    && OLD='<meta name="description" content="Neo4j Browser">' \
    && NEW='<meta name="description" content="Combat-TB-NeoDB Browser. Use Neo4j to query and explore a network of TB data.">' \
    && sed --in-place "s|$OLD|$NEW|" $HTML_PATH \
    && sed --in-place --expression='/<\/head>/r /google.html' --expression='x;$G' $HTML_PATH \
    && zip $JAR_PATH $HTML_PATH \
    && rm -r browser /google.html

# APOC, Algorithms and Guide settings 
RUN echo 'dbms.security.procedures.whitelist=apoc.*, algo.*' >> conf/neo4j.conf \
    && echo 'dbms.security.procedures.unrestricted=apoc.*, algo.*' >> conf/neo4j.conf \
    && echo 'dbms.unmanaged_extension_classes=extension.web=/guides' >> conf/neo4j.conf \
    ## The extension assumes that you added a 'guides' directory in the "data".
    && echo 'org.neo4j.server.guide.directory=data/guides' >> conf/neo4j.conf \ 
    && echo 'browser.remote_content_hostname_whitelist=*' >> conf/neo4j.conf \
    && echo 'apoc.import.file.enabled=true' >> conf/neo4j.conf \
    && echo 'dbms.logs.query.enabled=true' >> conf/neo4j.conf 
