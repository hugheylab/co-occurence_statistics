CREATE TABLE denny_omop_rd..FUDY_COOCCUR_ALL_PAIRS AS
(
SELECT
    A.person_id,
    C.event_date AS phecode_date,
    DATE_PART('MONTH', phecode_date) AS month_index,
    DATE_PART('YEAR', phecode_date) AS year_index,
    B.ingred_id,
    B.ingred_name,
    C.phecode
FROM denny_omop_rd..v_drug_exposure AS A
INNER JOIN denny_omop_rd..fudy_cooccur_drug_ingred AS B
ON A.drug_concept_id = B.drug_id
INNER JOIN denny_omop_rd..fudy_cooccur_all_phecode_events AS C
ON A.person_id = C.person_id AND
    (C.event_date BETWEEN A.drug_exposure_start_date - interval '30 days' AND A.drug_exposure_start_date)
WHERE
    C.event_date > '1999-12-31' AND C.event_date < '2017-1-1' AND
    B.ingred_id != 0 AND
    C.phecode IS NOT NULL
)
