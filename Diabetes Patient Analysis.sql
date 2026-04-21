-- ============================================
-- Diabetes Patient Analysis using SQL
-- ============================================
use db1;
-- 1. Patients with BMI greater than average
SELECT *
FROM health
WHERE BMI > (SELECT AVG(BMI) FROM health);


-- 2. Count diabetic vs non-diabetic patients
SELECT Outcome, COUNT(*) AS total_patients
FROM health
GROUP BY Outcome;


-- 3. BMI Category Classification
SELECT Id, Age, BMI,
CASE
    WHEN BMI < 18.5 THEN 'Underweight'
    WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal'
    WHEN BMI BETWEEN 25 AND 29.9 THEN 'Overweight'
    ELSE 'Obese'
END AS BMI_Category
FROM health;


-- 4. Rank patients by Glucose level
SELECT Id, Glucose,
RANK() OVER (ORDER BY Glucose DESC) AS glucose_rank
FROM health;


-- 5. High Risk Patients View
CREATE VIEW high_risk_patients AS
SELECT Id, Age, Glucose, BMI
FROM health
WHERE Glucose > 140 AND BMI > 30;

SELECT * FROM high_risk_patients;


-- 6. Top 5 patients with highest insulin
SELECT *
FROM health
ORDER BY Insulin DESC
LIMIT 5;


-- 7. Average Blood Pressure by Outcome
SELECT Outcome, AVG(BloodPressure) AS avg_bp
FROM health
GROUP BY Outcome;


-- 8. Age Group Distribution
SELECT 
CASE
    WHEN Age <= 30 THEN '0-30'
    WHEN Age BETWEEN 31 AND 50 THEN '31-50'
    ELSE '50+'
END AS age_group,
COUNT(*) AS total_patients
FROM health
GROUP BY age_group;


-- 9. Diabetes Summary View
CREATE VIEW diabetes_summary AS
SELECT  
CASE  
    WHEN Outcome = 1 THEN 'Diabetic' 
    ELSE 'Non-Diabetic' 
END AS Diabetes_Status,
AVG(Glucose) AS avg_glucose,
AVG(BloodPressure) AS avg_bp,
AVG(SkinThickness) AS avg_skin,
AVG(Insulin) AS avg_insulin,
AVG(BMI) AS avg_bmi,
AVG(DiabetesPedigreeFunction) AS avg_dpf,
AVG(Age) AS avg_age
FROM health
GROUP BY Outcome;

SELECT * FROM diabetes_summary;


-- 10. Patients with above-average Glucose AND BMI
SELECT *
FROM health
WHERE Glucose > (SELECT AVG(Glucose) FROM health)
AND BMI > (SELECT AVG(BMI) FROM health);