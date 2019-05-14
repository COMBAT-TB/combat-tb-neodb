FROM neo4j:3.5-enterprise
LABEL Name=combatb-db-dc Maintainer="thoba@sanbi.ac.za"

COPY dc/plugins/* plugins/
# COPY cors/guides/* guides/

ENV NEO4J_AUTH=none \
    NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    NEO4J_dbms_read__only=true \
    NEO4J_dbms_shell_read__only=true \
    # NEO4J_dbms_unmanaged__extension__classes='extension.web=/guides' \
    ## The extension assumes that you added a 'guides' directory in the "data".
    # NEO4J_org_neo4j_server_guide_directory='data/guides' \
    NEO4J_dbms_allow__upgrade=true \
    NEO4J_dbms_allow__format__migration=true \
    NEO4J_browser_post__connect__cmd='config; play http://localhost:7000/combattb_neodb.html' 


RUN echo 'dbms.security.procedures.whitelist=apoc.*, algo.*' >> conf/neo4j.conf \
    && echo 'dbms.security.procedures.unrestricted=apoc.*, algo.*' >> conf/neo4j.conf \
    # && echo 'dbms.unmanaged_extension_classes=extension.web=/guides' >> conf/neo4j.conf \
    # && echo 'org.neo4j.server.guide.directory=guides' >> conf/neo4j.conf \ 
    && echo 'browser.remote_content_hostname_whitelist=*' >> conf/neo4j.conf

