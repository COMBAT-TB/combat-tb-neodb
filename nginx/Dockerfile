FROM nginx:1.17-alpine
LABEL maintainer="thoba@sanbi.ac.za"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && mkdir -p /usr/share/nginx/html/guide \
    && wget https://raw.githubusercontent.com/COMBAT-TB/combat-tb-neodb/master/dc/guides/combattb_neodb.html \
    -P /usr/share/nginx/html/guide/

COPY nginx.conf /etc/nginx/
COPY SANBI_Wildcard.all.pem SANBI_Wildcard.key  /etc/nginx/ssl/
