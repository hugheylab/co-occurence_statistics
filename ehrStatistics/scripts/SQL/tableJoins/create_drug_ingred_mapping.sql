--Generates table with names/IDs of drugs and names/IDs of contained ingredients
CREATE TABLE denny_omop_rd..FUDY_COOCCUR_DRUG_INGRED AS 
(
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept as c2
on c2.concept_id = cr1.concept_id_2
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Clinical Drug Comp' and cr1.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Clinical Drug Form */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept as c2
on c2.concept_id = cr1.concept_id_2
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Clinical Drug Form' and cr1.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Clinical Drug */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr2.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Clinical Drug' and cr1.relationship_id = 'Consists of' and cr2.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Quant Clinical Drug */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr3
on cr2.concept_id_2 = cr3.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr3.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Quant Clinical Drug' and cr1.relationship_id = 'Quantified form of' and cr2.relationship_id = 'Consists of' and cr3.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Clinical Dose Group */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr1.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Clinical Dose Group' and cr1.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Clinical Pack */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr3
on cr2.concept_id_2 = cr3.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr3.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Clinical Pack' and cr1.relationship_id = 'Contains' and cr2.relationship_id = 'Consists of' and cr3.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Branded Drug Comp */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr2.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Branded Drug Comp' and cr1.relationship_id = 'Tradename of' and cr2.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Branded Drug Form */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr2.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Branded Drug Form' and cr1.relationship_id = 'Tradename of' and cr2.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Branded Pack */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr3
on cr2.concept_id_2 = cr3.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr4
on cr3.concept_id_2 = cr4.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr4.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Branded Pack' and cr1.relationship_id = 'Tradename of' and cr2.relationship_id = 'Contains' and cr3.relationship_id = 'Consists of' and cr4.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Branded Drug */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr3
on cr2.concept_id_2 = cr3.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr3.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Branded Drug' and cr1.relationship_id = 'Consists of' and cr2.relationship_id = 'Tradename of' and cr3.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Brand Name */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr1.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Brand Name' and cr1.relationship_id = 'Brand name of' and c2.concept_class_id = 'Ingredient'
union

/* Quant Branded Drug */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr3
on cr2.concept_id_2 = cr3.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr4
on cr3.concept_id_2 = cr4.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr4.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Quant Branded Drug' and cr1.relationship_id = 'Tradename of' and cr2.relationship_id = 'Quantified form of' and cr3.relationship_id = 'Consists of' and cr4.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Branded Dose Group */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept_relationship as cr2
on cr1.concept_id_2 = cr2.concept_id_1
inner join denny_omop_rd..v_concept as c2
on cr2.concept_id_2 = c2.concept_id
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Branded Dose Group' and cr1.relationship_id = 'Tradename of' and cr2.relationship_id = 'RxNorm has ing' and c2.concept_class_id = 'Ingredient'
union

/* Ingredient */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c1.concept_id as ingred_id, c1.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Ingredient'
union

/* Precise Ingredient */
select c1.concept_id as drug_id, c1.concept_name as drug_name, c2.concept_id as ingred_id, c2.concept_name as ingred_name
from denny_omop_rd..v_concept as c1
inner join denny_omop_rd..v_concept_relationship as cr1
on c1.concept_id = cr1.concept_id_1
inner join denny_omop_rd..v_concept as c2
on c2.concept_id = cr1.concept_id_2
where c1.vocabulary_id = 'RxNorm' and c1.concept_class_id = 'Precise Ingredient' and cr1.relationship_id = 'Form of' and c2.concept_class_id = 'Ingredient'
)