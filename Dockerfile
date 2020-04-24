FROM python:3.6-alpine
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
# NOTE: The python:alpine image would be lovely
# to use here, but it isn't compatible with the
# postgres SDK, per this issue:
# https://github.com/psycopg/psycopg2/issues/699

LABEL org.label-schema.schema-version = "1.0.0-rc.1"

LABEL org.label-schema.vendor = "Josh Schoenbachler"
LABEL org.label-schema.name = "Co-Occurence Statistics API"
LABEL org.label-schema.description = "API for querying against drug co-occurence statistics/"
LABEL org.label-schema.vcs-url = "https://github.com/hugheylab/co-occurence_statistics"
LABEL org.label-schema.url = "https://hugheylab.org"
LABEL maintainer="josh.schoenbachler@vumc.org"

LABEL org.label-schema.version = "0.7.0"

COPY API/requirements.txt /
RUN pip install -r API/requirements.txt

RUN apk add curl

ADD . /app
WORKDIR /app

HEALTHCHECK --start-period=30s --interval=120s --timeout=15s CMD curl --fail http://localhost/general_exposure || exit 1

CMD ["python", "API/server.py"]
