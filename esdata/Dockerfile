FROM elasticsearch:2.4.4-alpine
LABEL maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk add --no-cache openssl wget

COPY elasticsearch.yml config/

ENV DB_VERSION="1421060" \
    # ZENODO="https://zenodo.org/record/${DB_VERSION}/files/gff2neo_es_data.tar.bz2" \
    FIGSHARE="https://ndownloader.figshare.com/files/15564215"

RUN wget "${FIGSHARE}" \
    -O neodb_es_data.tar.bz2 \
    && mkdir esdata/ \
    && tar xvfj neodb_es_data.tar.bz2 -C esdata/ \
    && rm -rf neodb_es_data.tar.bz2 \
    && chown -R elasticsearch:elasticsearch .
