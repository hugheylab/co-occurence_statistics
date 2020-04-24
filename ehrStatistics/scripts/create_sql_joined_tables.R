library('RODBC')
library('readr')

runQueryFromFile = function(con, file){

    query = gsub('\\s+', ' ', read_file(file))
    result = sqlQuery(con, query, stringsAsFactors = FALSE, as.is = TRUE, errors = TRUE)
    return(result)

}

con = odbcConnect('NZSQL', believeNRows = FALSE)

#Create mapping table of ingredients in drugs
runQueryFromFile(con, file.path('ehrStatistics', 'scripts', 'SQL', 'tableJoins', 'create_drug_ingred_mapping.sql'))

#Create ICD9-ICD10 mappings
runQueryFromFile(con, file.path('ehrStatistics', 'scripts', 'SQL', 'tableJoins', 'create_icd_phecode_mapping.sql'))

#Create table of all ICD coded events
runQueryFromFile(con, file.path('ehrStatistics', 'scripts', 'SQL', 'tableJoins', 'combine_all_icd_events.sql'))

#Combine ICD events into Phecode events
runQueryFromFile(con, file.path('ehrStatistics', 'scripts', 'SQL', 'tableJoins', 'collapse_icd_to_phecode_events.sql'))

#Merge phecode table with drug exposures table (big table to do data extraction from)
runQueryFromFile(con, file.path('ehrStatistics', 'scripts', 'SQL', 'tableJoins', 'join_drug_and_phecodes.sql'))
