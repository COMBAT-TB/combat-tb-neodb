FROM alpine:latest
LABEL Name=combatb-db-dc Maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk upgrade \
    && mkdir -p /data/guides \
    && apk add --no-cache openssl

ENV DB_VERSION="3057235" \
    # ZENODO_URL="https://zenodo.org/record/${DB_VERSION}/files/neodb-db-data.tar.bz2" \
    FIGSHARE_URL="https://ndownloader.figshare.com/files/15192035"

RUN wget "${FIGSHARE_URL}" \
    -O neodb_db_data.tar.bz2 \
    && tar xvfj neodb_db_data.tar.bz2 \
    && rm -rf neodb_db_data.tar.bz2 \
    && cp -r databases /data/

COPY guides data/guides

VOLUME /data
