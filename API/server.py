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
        query = query + " WHERE ("
        idString = params.ids
        ids = []
        ids = idString.split(",")
        for idx in ids:
            query = query + " ingredient_id = '" + idx + "' OR"

        query = query[:-3]
        query = query + ")"

    if hasattr(params, "name") and params.name != '':
        if not isWhereAdded:
            query = query + " WHERE "
        else:
            query = query + " AND "
        nameQuery = params.name.lower()
        query = query + " LOWER(ingredient_name) LIKE '%" + nameQuery + "%' "
        
    query = query + " limit "+limit
    genExps = connection.read(query)
    for ge in genExps:
        results.append(ge)
    return {
        "results": [r for r in results]
        }
@bottle.get('/phenotype_specific_exposures')
def index():
    params = bottle.request.query
    results = []
    query = "SELECT ingredient_id, ingredient_name, phecode, phecode_name, paired_count, phecode_cound, phenotype_specific_exposure, enrichment, medi_status FROM public.phenotype_specific_exposures"
    limit = "50"
    isWhereAdded = False
    if hasattr(params, "limit") and params.limit != "":
        limit = params.limit

    if hasattr(params, "phecodeIds") and params.phecodeIds != '':
        isWhereAdded = True
        query = query + " WHERE ("
        phecodeIdString = params.phecodeIds
        phecodeIds = []
        phecodeIds = phecodeIdString.split(",")
        for idx in phecodeIds:
            query = query + " phecode = '" + idx + "' OR"

        query = query[:-3]
        query = query + ")"

    if hasattr(params, "ingredientIds") and params.ingredientIds != '':
        if not isWhereAdded:
            query = query + " WHERE ("
        else:
            query = query + " AND ("
        isWhereAdded = True
        ingredientIdString = params.ingredientIds
        ingredientIds = []
        ingredientIds = ingredientIdString.split(",")
        for idx in ingredientIds:
            query = query + " ingredient_id = '" + idx + "' OR"

        query = query[:-3]
        query = query + ")"

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
