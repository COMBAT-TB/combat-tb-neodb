FROM elasticsearch:2.4
LABEL maintainer="thoba@sanbi.ac.za"

COPY elasticsearch.yml config/

ENV DB_VERSION="1260446"

RUN wget "https://zenodo.org/record/${DB_VERSION}/files/gff2neo_es_data.tar.bz2" \
    -O gff2neo_es_data.tar.bz2 \
    && mkdir esdata/ \
    && tar xvfj gff2neo_es_data.tar.bz2 -C esdata/ \
    && rm -rf gff2neo_es_data.tar.bz2 \
    && chown -R elasticsearch:elasticsearch .
