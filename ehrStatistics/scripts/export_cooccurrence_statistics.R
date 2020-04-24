library(data.table)

#Read RDS Data
phecodeIngreds = readRDS(file.path('ehrStatistics', 'processed', 'phecode_ingreds_pairs_above_cutoff.rds'))

#Extract out general exposures of each ingredient
genExpData = unique(phecodeIngreds[, .(INGRED_ID, INGRED_NAME, X_ANY, GEN_EXP)])
names(genExpData) = c('ingredient_id', 'ingredient_name', 'general_exposure_count', 'general_exposure')
fwrite(genExpData, file.path('ehrStatistics', 'export', 'general_exposures.csv'))

#Extract out specific exposures and enrichment of each ingredient-phecode pair
psExpData = unique(phecodeIngreds[PEOPLE > 0, .(INGRED_ID, INGRED_NAME, PHECODE, PHECODE_NAME, PEOPLE, ANY_Y, PS_EXP, ENRICH, STATUS)])
names(psExpData) = c('ingredient_id', 'ingredient_name', 'phecode', 'phecode_name', 'paired_count', 'phecode_count', 'phenotype_specific_exposure', 'enrichment', 'medi_status')
fwrite(psExpData, file.path('ehrStatistics', 'export', 'phenotype_specific_exposures.csv'))