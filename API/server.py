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
    query = "SELECT ingredient_id, ingredient_name, general_exposure_count, general_exposure FROM public.general_exposures"
    limit = "50"
    isWhereAdded = False
    if hasattr(params, "limit") and params.limit != "":
        limit = params.limit
    if hasattr(params, "ids") and params.ids != '':
        isWhereAdded = True
        query = query + " WHERE "
        idString = params.ids
        ids = []
        ids = idString.split(",")
        for idx in ids:
            query = query + " ingredient_id = '" + idx + "' OR"

        query = query[:-3]

    if hasattr(params, "name") and params.name != '':
        if !isWhereAdded:
            query = query + " WHERE "
        else:
            query = query + " AND "
        query = query + "ingredient_name LIKE '%" + params.name + "%' "
        
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
