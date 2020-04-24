SELECT
    ingred_id,
    ingred_name,
    phecode,
    COUNT(DISTINCT(person_id)) AS PEOPLE
FROM denny_omop_rd..FUDY_COOCCUR_ALL_PAIRS
GROUP BY ingred_id, ingred_name, phecode