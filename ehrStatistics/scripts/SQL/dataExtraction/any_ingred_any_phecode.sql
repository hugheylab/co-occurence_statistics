SELECT
    COUNT(DISTINCT(person_id)) AS PEOPLE
FROM denny_omop_rd..FUDY_COOCCUR_ALL_PHECODE_EVENTS
WHERE event_date > '1999-12-31' AND event_date < '2017-1-1'
