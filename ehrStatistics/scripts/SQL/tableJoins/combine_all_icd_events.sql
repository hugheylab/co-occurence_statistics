--Get all ICD coded events from all table types
CREATE TABLE denny_omop_rd..FUDY_COOCCUR_ALL_ICD_EVENTS AS
(SELECT DISTINCT
    A.person_id,
    A.condition_start_date AS event_date,
    C.domain_id,
    C.vocabulary_id,
    C.concept_code,
    C.concept_id
FROM denny_omop_rd..v_condition_occurrence AS A
INNER JOIN denny_omop_rd..v_concept AS C
    ON A.condition_source_concept_id = C.concept_id
WHERE
    C.vocabulary_id IN ('ICD10CM', 'ICD10PCS', 'ICD9CM', 'ICD9PROC')
UNION
SELECT DISTINCT
    A.person_id,
    A.procedure_date AS event_date,
    C.domain_id,
    C.vocabulary_id,
    C.concept_code,
    C.concept_id
FROM denny_omop_rd..v_procedure_occurrence AS A
INNER JOIN denny_omop_rd..v_concept AS C
    ON A.procedure_source_concept_id = C.concept_id
WHERE
    C.vocabulary_id IN ('ICD10CM', 'ICD10PCS', 'ICD9CM', 'ICD9PROC')
UNION
SELECT DISTINCT
    A.person_id,
    A.observation_date AS event_date,
    C.domain_id,
    C.vocabulary_id,
    C.concept_code,
    C.concept_id
FROM denny_omop_rd..v_observation AS A
INNER JOIN denny_omop_rd..v_concept AS C
    ON A.observation_source_concept_id = C.concept_id
WHERE
    C.vocabulary_id IN ('ICD10CM', 'ICD10PCS', 'ICD9CM', 'ICD9PROC')
UNION
SELECT DISTINCT
    A.person_id,
    A.measurement_date AS event_date,
    C.domain_id,
    C.vocabulary_id,
    C.concept_code,
    C.concept_id
FROM denny_omop_rd..v_measurement AS A
INNER JOIN denny_omop_rd..v_concept AS C
    ON A.measurement_source_concept_id = C.concept_id
WHERE
    C.vocabulary_id IN ('ICD10CM', 'ICD10PCS', 'ICD9CM', 'ICD9PROC'))