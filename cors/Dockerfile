FROM python:3-alpine
LABEL maintainer="thoba@sanbi.ac.za"

# Run a CORS webserver to serve the HTML
COPY ["guides", "http-server.py","./"]

EXPOSE 7000

CMD [ "python3", "http-server.py" ]


