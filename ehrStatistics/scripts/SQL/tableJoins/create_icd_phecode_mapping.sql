--Create a local table using the csv file
CREATE EXTERNAL TABLE icd9_phecode_map (
    ICD9_CODE VARCHAR(20),
    PHECODE VARCHAR(20)
 )
USING (
  DATAOBJECT('/Users/darwin/Git-Hughey/DrugCourses/PaperDataExtraction/data/icd9cm_phecode12_import.csv') 
  REMOTESOURCE 'jdbc'
  DELIMITER ','
  SKIPROWS 1
  MAXERRORS 1000
  LOGDIR '/Users/darwin/Git-Hughey/DrugCourses/PaperDataExtraction/processed/');

--Select from external table onto Netezza server
CREATE TABLE denny_omop_rd..FUDY_ICD9_PHECODE_MAP AS SELECT * FROM icd9_phecode_map


--Create a local table using the csv file
CREATE EXTERNAL TABLE icd10_phecode_map (
    ICD10_CODE VARCHAR(20),
    PHECODE VARCHAR(20)
 )
USING (
  DATAOBJECT('/Users/darwin/Git-Hughey/DrugCourses/PaperDataExtraction/data/icd10cm_phecode12b1_import.csv') 
  REMOTESOURCE 'jdbc'
  DELIMITER ','
  SKIPROWS 1
  MAXERRORS 1000
  LOGDIR '/Users/darwin/Git-Hughey/DrugCourses/PaperDataExtraction/processed/');

--Select from external table onto Netezza server
CREATE TABLE denny_omop_rd..FUDY_ICD10_PHECODE_MAP AS SELECT * FROM icd10_phecode_map