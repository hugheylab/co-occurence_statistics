#!/usr/bin/python3
from json import dumps
import bottle
import db
import config

connection = db.Connection(config.db["host"], config.db["db"], config.db["user"], config.db["password"])

@bottle.get('/general_exposure')
def index():
    params = bottle.request.query
    results = []
    query = "SELECT ingredient_id, ingrediend_name, general_exposure_count, general_exposure FROM public.general_exposures"
    limit = params.limit
    if limit == null || limit == undefined || limit == "":
        limit = 50
    if params.ids != null && params.ids != undefined && params.ids != '':
        ids = []
        ids = query.ids.split(",")
        for idx in ids:
            query = query + " ingredient_id = " + idx + " OR"

        query[:-3]

    query = query + " limit "+limit
    genExps = connection.read(query)
    for ge in genExps:
        results.append(ge)
    return {
        "results": [r for r in results]
        }
    


# ---- Errors
@bottle.error(404)
def error404(error):
  bottle.response.set_header("Content-Type", "application/json")
  return "{\"error\": \"unrecognized URL\"}"

# - SERVER -
if config.use_prod_webserver:
  bottle.run(host='0.0.0.0', port=80, server="gunicorn")
else:
  bottle.run(host='0.0.0.0', port=80, debug=True, reloader=True)
