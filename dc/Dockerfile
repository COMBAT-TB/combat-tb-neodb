FROM alpine:latest
LABEL Name=combatb-db-dc Maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk upgrade \
    && mkdir -p /data/guides \
    && apk add --no-cache openssl

ENV DB_VERSION="1421060"

RUN wget "https://zenodo.org/record/${DB_VERSION}/files/gff2neo_db_data.tar.bz2" \
    -O gff2neo_db_data.tar.bz2 \
    && tar xvfj gff2neo_db_data.tar.bz2 \
    && cp -r databases /data/

COPY guides data/guides

VOLUME /data
