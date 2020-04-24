--Combine ICD events into phecode events
CREATE TABLE denny_omop_rd..FUDY_COOCCUR_ALL_PHECODE_EVENTS AS
(SELECT DISTINCT
    A.person_id,
    A.event_date,
    DATE_PART('MONTH', A.event_date) AS month_index,
    DATE_PART('YEAR', A.event_date) AS year_index,
    M.phecode
FROM denny_omop_rd..FUDY_COOCCUR_ALL_ICD_EVENTS  AS A
INNER JOIN denny_omop_rd..FUDY_ICD9_PHECODE_MAP AS M
    ON A.concept_code = M.ICD9_CODE
WHERE
    A.vocabulary_id IN ('ICD9CM', 'ICD9PROC')
UNION
SELECT DISTINCT
    A.person_id,
    A.event_date,
    DATE_PART('MONTH', A.event_date) AS month_index,
    DATE_PART('YEAR', A.event_date) AS year_index,
    M.phecode
FROM denny_omop_rd..FUDY_COOCCUR_ALL_ICD_EVENTS  AS A
INNER JOIN denny_omop_rd..FUDY_ICD10_PHECODE_MAP AS M
    ON A.concept_code = M.ICD10_CODE
WHERE
    A.vocabulary_id IN ('ICD10CM', 'ICD10PCS'))
