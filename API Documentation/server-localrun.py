#!/usr/bin/python3
import db
import config

connection = db.Connection(config.db["host"], config.db["db"], config.db["user"], config.db["password"])
results = []
genExps = connection.read("SELECT ingredient_id, ingredient_name, general_exposure_count, general_exposure FROM public.general_exposures limit 50;")
i = 1
for ge in genExps:
    print(i)
    print(ge)
    i = i + 1

    
