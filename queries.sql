-- Question 1: How many animals of each type have outcomes (counting each animal once, not each outcome)?
SELECT animal_type, COUNT(DISTINCT animal_id) as animal_count
FROM Animal
GROUP BY animal_type;

-- Question 2: How many animals are there with more than 1 outcome?
WITH AnimalOutcomeCounts AS (
    SELECT animal_id, COUNT(*) as outcome_count
    FROM Relationship
    GROUP BY animal_id
)
SELECT COUNT(*)
FROM AnimalOutcomeCounts
WHERE outcome_count > 1;

-- Question 3: What are the top 5 months for outcomes (ignoring years)?
SELECT EXTRACT(MONTH FROM date_time) as outcome_month, COUNT(*) as outcome_count
FROM Outcome
GROUP BY outcome_month
ORDER BY outcome_count DESC
LIMIT 5;

-- Question 4: What is the total number percentage of kittens, adults, and seniors, whose outcome is "Adopted"?
SELECT age_category, (COUNT(*) / total_count::numeric) * 100 as percentage
FROM (
    SELECT
        CASE
            WHEN age_years < 1 THEN 'Kitten'
            WHEN age_years >= 1 AND age_years <= 10 THEN 'Adult'
            WHEN age_years > 10 THEN 'Senior'
        END as age_category,
        COUNT(*) as total_count
    FROM (
        SELECT
            a.animal_id,
            EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM a.dob) as age_years
        FROM Animal a
        WHERE EXISTS (
            SELECT 1
            FROM Relationship r
            WHERE r.animal_id = a.animal_id
            AND r.age_at_outcome = '0 years' -- Modify as per your age representation
            AND EXISTS (
                SELECT 1
                FROM Outcome o
                WHERE r.date_time = o.date_time
                AND o.outcome_type = 'Adopted'
            )
        )
    ) subquery
    GROUP BY age_category
) final_result;

-- Question 5: Conversely, among all the cats who were "Adopted," what is the total number percentage of kittens, adults, and seniors?
WITH CatAdoptions AS (
    SELECT a.animal_id, EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM a.dob) as age_years
    FROM Animal a
    WHERE a.animal_type = 'Cat'
    AND EXISTS (
        SELECT 1
        FROM Relationship r
        WHERE r.animal_id = a.animal_id
        AND r.age_at_outcome = '0 years' -- Modify as per your age representation
        AND EXISTS (
            SELECT 1
            FROM Outcome o
            WHERE r.date_time = o.date_time
            AND o.outcome_type = 'Adopted'
        )
    )
)
SELECT age_category, (COUNT(*) / total_count::numeric) * 100 as percentage
FROM (
    SELECT
        CASE
            WHEN age_years < 1 THEN 'Kitten'
            WHEN age_years >= 1 AND age_years <= 10 THEN 'Adult'
            WHEN age_years > 10 THEN 'Senior'
        END as age_category,
        COUNT(*) as total_count
    FROM CatAdoptions
    GROUP BY age_category
) final_result;
