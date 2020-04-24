library(data.table)

addMEDIData = function(pairedData){

    mediData = readRDS(file.path('ehrStatistics', 'data', 'medi_phecodes.rds'))
    pairedData$HPS = mediData[.(pairedData$INGRED_NAME, pairedData$PHECODE)]$HPS
    pairedData$ON_LABEL = mediData[.(pairedData$INGRED_NAME, pairedData$PHECODE)]$ON_LABEL
    pairedData$ICD_CODES = mediData[.(pairedData$INGRED_NAME, pairedData$PHECODE)]$ICD_CODES

    pairedData$IN_MEDI = 1
    pairedData[is.na(ICD_CODES), IN_MEDI := 0]

    pairedData[, STATUS := 'Not In Medi']
    pairedData[IN_MEDI == 1, STATUS := 'In Medi']
    pairedData[IN_MEDI == 1 & HPS == 1, STATUS := 'HPS']

    pairedData[, STATUS := factor(STATUS, levels = c('Not In Medi', 'In Medi', 'HPS'))]

    return(pairedData)
}

# A / B - Patients with ingred X + phecode Y over patients with any ingred and phecode Y
# C / D - Patients with ingred X + any phecode over patients with any phecode and any ingred

#A data table (Pair co-occurence counts)
phecodeIngreds = readRDS(file.path('ehrStatistics', 'data', 'ingred_X_phecode_Y.rds'))

# B data table (Phecode occurrence counts)
anyIngredPhecodeY = readRDS(file.path('ehrStatistics', 'data', 'any_ingred_phecode_Y.rds'))
setkey(anyIngredPhecodeY, PHECODE)

#Filter for low counts
phecodeIngreds = phecodeIngreds[PEOPLE >= 25]

#Phecode filtering
#Remove "Other tests" generic phecode
phecodeIngreds = phecodeIngreds[PHECODE != 1010]

#Remove Phecodes with fewer than 100 occurrences overall
phecodeIngreds = phecodeIngreds[PHECODE %in% anyIngredPhecodeY[PEOPLE >= 100]$PHECODE]

#Add 0s for Phecode-Ingredients that don't exist (or had fewer than cutoff number of cases)
allCombos = CJ(INGRED_ID = unique(phecodeIngreds$INGRED_ID), PHECODE = unique(phecodeIngreds$PHECODE))

#Add ingredient names to Phecode-Ingredients with 0 count
#Phecode names added later with Phecode dict
allCombos = merge(allCombos, unique(phecodeIngreds[, c('INGRED_ID', 'INGRED_NAME')]), by = c('INGRED_ID'), all.x = TRUE)

#merge with found ingredient-phecode pairs
phecodeIngreds = merge(allCombos, phecodeIngreds, by = c('INGRED_ID', 'INGRED_NAME', 'PHECODE'), all.x = TRUE)
phecodeIngreds[is.na(phecodeIngreds)] = 0

#################### Add data for phenotype specific exposure and enrichment

#Clean data and add names

#Add phecode names and remove phecodes without name in dictionary
phecodeDict = readRDS(file.path('ehrStatistics', 'data', 'phecode_dict.rds'))

phecodeIngreds$PHECODE_NAME = phecodeDict[.(phecodeIngreds$PHECODE)]$PHECODE_NAME
phecodeIngreds = phecodeIngreds[!is.na(PHECODE_NAME)]

#Read in additional data necessary for enrichments and calculations

# C data table (Ingredient occurrence counts)
ingredXAnyPhecode = readRDS(file.path('ehrStatistics', 'data', 'ingred_X_any_phecode.rds'))
setkey(ingredXAnyPhecode, INGRED_ID)

# D value (Total patient population)
anyIngredAnyPhecode = readRDS(file.path('ehrStatistics', 'data', 'any_ingred_any_phecode.rds'))

# B - patient with any ingred and specific phecode Y
phecodeIngreds$ANY_Y = anyIngredPhecodeY[.(phecodeIngreds$PHECODE)]$PEOPLE

# C - Patients with ingred X + any phecode
phecodeIngreds$X_ANY = ingredXAnyPhecode[.(phecodeIngreds$INGRED_ID)]$PEOPLE

# D - Patients with any phecode and any ingred
phecodeIngreds$ANY_ANY = anyIngredAnyPhecode$PEOPLE

#Calculate phenotype specific exposure, general exposure, and enrichments
phecodeIngreds[, PS_EXP := PEOPLE / ANY_Y * 100]
phecodeIngreds[, GEN_EXP := X_ANY / ANY_ANY * 100]
phecodeIngreds[, ENRICH := PS_EXP / GEN_EXP]

#Add MEDI codes and STATUS
phecodeIngreds = addMEDIData(phecodeIngreds)

#Save data with value meeting cutoff (and added zeros to complete matrix)
saveRDS(phecodeIngreds, file.path('ehrStatistics', 'processed', 'phecode_ingreds_pairs_above_cutoff.rds'))
