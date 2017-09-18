FROM openjdk:8-jre-alpine

RUN apk add --no-cache --quiet \
    bash \
    curl

ENV NEO4J_SHA256=65e1de8a025eae4ba42ad3947b7ecbf758a11cf41f266e8e47a83cd93c1d83d2 \
    NEO4J_TARBALL=neo4j-community-3.2.3-unix.tar.gz
ARG NEO4J_URI=http://dist.neo4j.org/neo4j-community-3.2.3-unix.tar.gz

RUN curl --fail --silent --show-error --location --remote-name ${NEO4J_URI} \
    && echo "${NEO4J_SHA256}  ${NEO4J_TARBALL}" | sha256sum -csw - \
    && tar --extract --file ${NEO4J_TARBALL} --directory /var/lib \
    && mv /var/lib/neo4j-* /var/lib/neo4j \
    && rm ${NEO4J_TARBALL} \
    && mv /var/lib/neo4j/data /data \
    && ln -s /data /var/lib/neo4j/data \
    && apk del curl

WORKDIR /var/lib/neo4j

VOLUME /data

COPY plugins/*.jar plugins/
COPY plugins/*.html guides/

ENV NEO4J_dbms_read__only=true

ENV NEO4J_dbms_unmanaged__extension__classes='extension.web=/guides'

ENV NEO4J_org_neo4j_server_guide_directory='data/guides'

ENV NEO4J_dbms__allow__format__migration=true

# ENV NEO4J_dbms_browser_remote__content__hostname__whitelist='http://localhost:7474/'

ENV NEO4J_dbms_security_procedures_unrestricted='apoc.\\\*'

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]