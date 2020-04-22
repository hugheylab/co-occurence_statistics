#!/usr/bin/python3
from json import dumps
import bottle
import db
import config

connection = db.Connection(config.db["host"], config.db["db"], config.db["user"], config.db["password"])

#General Exposure Endpoint
@bottle.get('/general_exposure')
def index():
    #Assigns parameters to a variable object
    params = bottle.request.query
    results = []
    #Initializes query to build the string to query for
    query = "SELECT ingredient_id, ingredient_name, general_exposure_count, general_exposure FROM public.general_exposures"
    #Sets initial limit to the default of 50 results
    limit = "50"
    #Has a boolean variable to determine if a WHERE clause has been added yet. Is used to determine if in a query WHERE needs to be added or if AND needs to be added
    isWhereAdded = False
    #Checks for an attribute of limit to specify how many results to limit the query to
    if hasattr(params, "limit") and params.limit != "":
        limit = params.limit
    #Checks for a parameter of ids, a comma separated list of ingredient Ids to query for
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
    #Checks for a name parameter to search by ingredient_name in a case insensitive contains method
    if hasattr(params, "name") and params.name != '':
        #If not isWhereAdded we just add an AND instead of WHERE
        if not isWhereAdded:
            query = query + " WHERE "
        else:
            query = query + " AND "
        nameQuery = params.name.lower()
        query = query + " LOWER(ingredient_name) LIKE '%" + nameQuery + "%' "
    #Appends limit to query
    query = query + " limit "+limit
    #Sends query to connection to database
    genExps = connection.read(query)
    #Returns results, adds them to a list, then puts them in a JSON list
    for ge in genExps:
        results.append(ge)
    return {
        "results": [r for r in results]
        }

#Phenotype Specific Exposures Endpoint
@bottle.get('/phenotype_specific_exposures')
def index():
    #Assigns parameters to a variable object
    params = bottle.request.query
    results = []
    #Initializes query to build the string to query for
    query = "SELECT ingredient_id, ingredient_name, phecode, phecode_name, paired_count, phecode_cound, phenotype_specific_exposure, enrichment, medi_status FROM public.phenotype_specific_exposures"
    #Sets initial limit to the default of 50 results
    limit = "50"
    #Has a boolean variable to determine if a WHERE clause has been added yet. Is used to determine if in a query WHERE needs to be added or if AND needs to be added
    isWhereAdded = False
    #Checks for an attribute of limit to specify how many results to limit the query to
    if hasattr(params, "limit") and params.limit != "":
        limit = params.limit
    #Checks for a parameter of phecodeIds, a comma separated list of phecodes to query for
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
    #Checks for a parameter of ingredientIds, a comma separated list of ingredient Ids to query for
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
