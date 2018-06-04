FROM alpine:3.7
LABEL Name=combatb_web-dc Version="0.1" Maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk upgrade \
    && mkdir /data \
    && apk add --no-cache ca-certificates openssl curl \
    && update-ca-certificates

ENV DB_VERSION="1260446"

RUN wget "https://zenodo.org/record/${DB_VERSION}/files/gff2neo_db_data.tar.bz2" \
    -O gff2neo_db_data.tar.bz2 \
    && tar xvfj gff2neo_db_data.tar.bz2 \
    && cp -r databases /data/

VOLUME /data
