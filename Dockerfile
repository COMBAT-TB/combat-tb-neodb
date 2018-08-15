FROM neo4j:3.4

COPY plugins/*.jar plugins/
COPY guides/*.html guides/

ENV NEO4J_dbms_unmanaged__extension__classes='extension.web=/guides' \
    NEO4J_org_neo4j_server_guide_directory='guides' \
    NEO4J_dbms_allow__upgrade=true \
    NEO4J_dbms_allow__format__migration=true \
    # NEO4J_browser_post__connect__cmd="play http://localhost:7474/guides/combattb_graph.html" \
    # NEO4J_dbms_read__only=true \
    # NEO4J_dbms_shell_read__only=true \
    NEO4J_dbms_security_procedures_unrestricted='apoc.\\\*' 
RUN echo 'browser.remote_content_hostname_whitelist=*' >> conf/neo4j.conf
