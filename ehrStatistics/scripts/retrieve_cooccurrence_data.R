library('data.table')
library('RODBC')
library('readr')

queryIngredXPhecodeY = function(con){

    query = gsub('\\s+', ' ', read_file(file.path('ehrStatistics', 'scripts', 'SQL', 'datatExtraction', 'ingred_X_phecode_Y.sql')))
    result = setDT(sqlQuery(con, query, stringsAsFactors = FALSE, as.is = TRUE))

    result[, INGRED_ID := as.numeric(INGRED_ID)]
    result[, INGRED_NAME := as.character(INGRED_NAME)]
    result[, PHECODE := as.character(PHECODE)]
    result[, PEOPLE := as.numeric(PEOPLE)]

    saveRDS(result, file.path('ehrStatistics', 'data', 'ingred_X_phecode_Y.rds'), compress = FALSE)

}

queryAnyIngredPhecodeY = function(con){

    query = gsub('\\s+', ' ', read_file(file.path('ehrStatistics', 'scripts', 'SQL', 'datatExtraction', 'any_ingred_phecode_Y.sql')))
    result = setDT(sqlQuery(con, query, stringsAsFactors = FALSE, as.is = TRUE))

    result[, PHECODE := as.character(PHECODE)]
    result[, PEOPLE := as.numeric(PEOPLE)]

    setkey(result, PHECODE)

    saveRDS(result, file.path('ehrStatistics', 'data', 'any_ingred_phecode_Y.rds'), compress = FALSE)

}

queryIngredXAnyPhecode = function(con){

    query = gsub('\\s+', ' ', read_file(file.path('ehrStatistics', 'scripts', 'SQL', 'datatExtraction', 'ingred_X_any_phecode.sql')))
    result = setDT(sqlQuery(con, query, stringsAsFactors = FALSE, as.is = TRUE))

    result[, INGRED_ID := as.numeric(INGRED_ID)]
    result[, INGRED_NAME := as.character(INGRED_NAME)]
    result[, PEOPLE := as.numeric(PEOPLE)]

    setkey(result, INGRED_ID)

    saveRDS(result, file.path('ehrStatistics', 'data', 'ingred_X_any_phecode.rds'), compress = FALSE)
}

queryAnyIngredAnyPhecode = function(con){

    query = gsub('\\s+', ' ', read_file(file.path('ehrStatistics', 'scripts', 'SQL', 'datatExtraction', 'any_ingred_any_phecode.sql')))
    result = setDT(sqlQuery(con, query, stringsAsFactors = FALSE, as.is = TRUE))

    result[, PEOPLE := as.numeric(PEOPLE)]

    saveRDS(result, file.path('ehrStatistics', 'data', 'any_ingred_any_phecode.rds'), compress = FALSE)

}

con = odbcConnect('NZSQL', believeNRows = FALSE)

print('Processing Any Ingred - Any Phecode')
queryAnyIngredAnyPhecode(con)

print('Processing Ingred X - Phecode Y')
queryIngredXPhecodeY(con)

print('Processing Any Ingred - Phecode Y')
queryAnyIngredPhecodeY(con)

print('Processing Ingred X - Any Phecode')
queryIngredXAnyPhecode(con)
